"""Operations for the installer"""
#!/bin/python

import json
from os import path
from asyncio import run

import click

from system import spawn_process, spawn_processes, spawn_process_async, spawn_processes_async
from system import get_output as system

DEBUG = True

if DEBUG:
    target_path = ".config/yadm/targets"
else:
    target_path = "~/.config/yadm/targets"


async def install_repo(repo: dict[str, str]) -> bool:
    """Install a repository from a dictionary containing the name, bootstrap commands and pacman configuration entry"""
    click.clear()
    click.echo("Enabling repository {}".format(repo["name"]))
    click.echo("")

    if not await spawn_processes(repo["bootstrap_commands"]):
        return False

    if not await spawn_process(
            "echo -e \"{}\" | sudo tee -a /etc/pacman.conf".format(repo["pacman_entry"])):
        return False


async def install(target: str) -> bool:
    """Install a target configuration."""
    if not path.exists("{}/{}.json".format(target_path, target)):
        click.echo("Target configuration {} not found.".format(target))
        return False

    with open("{}/{}.json".format(target_path, target), "r") as f:
        target_config = json.load(f)

        for dependency in target_config["depends"]:
            if not install(dependency):
                return False

        for optional_repo in target_config["optional_repos"]:
            if click.confirm("Install optional repository {}?".format(optional_repo["name"])):
                if not install_repo(optional_repo):
                    return False


def get_branches() -> list[str]:
    """Get all branches of the current yadm repository"""
    blacklisted = ["HEAD", "main", "installer", "boilerplate"]

    branches = []

    # Get all remote branches and iterate through them
    for branch in system("yadm branch -r").split("\n"):
        # if the blacklist does not contain a part of the branch name, add it to the list
        if not any([blacklisted_branch in branch for blacklisted_branch in blacklisted]):
            branches.append(branch[9:])

    return branches


@click.command()
@click.option("--mode", prompt="Set operation mode (install, uninstall, list, create, delete, edit)", default="install", help="Set operation mode (install, uninstall, list, create, delete, edit)")
def main(mode: str) -> bool:
    """Entry point of the installer"""
    click.echo("Currently searching for targets on path: {}".format(target_path))

    match mode:
        case "install":
            click.echo("Available target branches:")
            for branch in get_branches():
                click.echo(branch)
            target_branch = click.prompt(
                "Enter target branch")

            system("yadm checkout {}".format(target_branch))

            target = click.prompt("Enter target name")

            return run(install(target))


if __name__ == "__main__":
    if main():
        click.echo("Target configuration installed successfully.")
    else:
        click.echo("Target configuration installation failed.")
