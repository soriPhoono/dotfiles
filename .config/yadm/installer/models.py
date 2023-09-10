import json
from os import path

import click

from system import spawn_process, spawn_processes, spawn_process_async, spawn_processes_async
from system import get_output as system

DEBUG = True

if DEBUG:
    target_path = ".config/yadm/targets"
else:
    target_path = "~/.config/yadm/targets"

user = system("whoami")


class Repository(object):
    def __init__(self, name: str, setup_commands: list[str], pacman_entry: str) -> None:
        self.name = name
        self.setup_commands = setup_commands
        self.pacman_entry = pacman_entry

    async def install(self) -> bool:
        """Install the repository"""
        click.clear()
        click.echo("Enabling repository {}".format(self.name))
        click.echo("")

        if not await spawn_processes(self.setup_commands):
            return False

        if not await spawn_process(
                "echo -e \"{}\" | sudo tee -a /etc/pacman.conf".format(self.pacman_entry)):
            return False

        return True


class ConfigurationFile(object):
    def __init__(self, source, backup: str, setup_commands: list[str]) -> None:
        self.source = source
        self.backup = backup
        self.setup_commands = setup_commands

    async def install(self) -> bool:
        """Install the configuration file alterations"""
        click.clear()
        click.echo("Installing configuration file {}".format(self.source))
        click.echo("")

        if not path.exists(self.source):
            click.echo("Configuration file {} not found.".format(self.source))
            return False

        needs_sudo = not self.source.startswith("/home/{}".format(user))

        if path.exists(self.source + ".bak"):
            if click.confirm("Configuration backup file {} exists already. Continue? The backup will be restored to the active state"):
                if not await spawn_process("{}mv {} {}".format("sudo " if needs_sudo else "", self.source, self.source + ".bak")):
                    return False
            else:
                return False

        match self.backup:
            case "move":
                if not await spawn_process("{}mv {} {}".format("sudo " if needs_sudo else "", self.source, self.source + ".bak")):
                    return False
            case "copy":
                if not await spawn_process("{}cp {} {}".format("sudo " if needs_sudo else "", self.source, self.source + ".bak")):
                    return False

        return await spawn_processes_async(self.setup_commands)


class Package(object):
    def __init__(self, name: str, depends: list[str], conflicts: list[str], source: str, post_install: list[str], config_files: list[ConfigurationFile]) -> None:
        self.name = name
        self.depends = depends
        self.conflicts = conflicts
        self.source = source
        self.post_install = post_install
        self.config_files = config_files

    async def install(self) -> bool:
        """Install the package"""
        click.clear()
        click.echo("Installing package {}".format(self.name))
        click.echo("")

        if not await spawn_process("sudo pacman -S --noconfirm {}".format(self.name)):
            return False

        if not await spawn_processes_async(self.post_install):
            return False

        for config_file in self.config_files:
            if not await config_file.install():
                return False

        return True


class Service(object):
    def __init__(self, name: str, user: bool, operation: str) -> None:
        self.name = name
        self.user = user
        self.operation = operation

    async def install(self) -> bool:
        """Install the service"""
        click.clear()
        click.echo("Installing service {}".format(self.name))
        click.echo("")

        if not await spawn_process("{}systemctl {} {}".format("" if self.user else "sudo ", self.operation, self.name)):
            return False

        return True


class Target(object):
    def __init__(self):
        self.depends: list[str] = []
        self.config_files: list[ConfigurationFile] = []
        self.optional_repos: list[Repository] = []
        self.packages: list[Package] = []
        self.services: list[Service] = []

        try:
            with open("{}/primary.json".format(target_path)) as f:
                raw = json.load(f)

                self.depends = raw["depends"]
                self.config_files = [ConfigurationFile(
                    **config_file) for config_file in raw["config_files"]]
                self.optional_repos = [Repository(
                    **repo) for repo in raw["optional_repos"]]
                self.packages = [Package(**package)
                                 for package in raw["packages"]]
                self.services = [Service(**service)
                                 for service in raw["services"]]
        except FileNotFoundError:
            click.echo(
                "No target configuration found, please configure installation process.")
            exit(1)

    async def install(self) -> bool:
        """Install the target configuration."""
        for dependency in self.depends:
            if not Target(dependency).install():
                return False

        for config_file in self.config_files:
            if not config_file.install():
                return False

        for optional_repo in self.optional_repos:
            if click.confirm("Install optional repository {}?".format(optional_repo["name"])):
                if not optional_repo.install():
                    return False

        for package in self.packages:
            if not package.install():
                return False

        for service in self.services:
            if not service.install():
                return False

        return True
