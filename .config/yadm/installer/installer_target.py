import subprocess

import click

from system import check_return


class InstallerTarget:
    """Base class for installer targets"""

    def __init__(self) -> None:
        super().__init__()

        self.package_handler: str = "paru -S --noconfirm --needed"

        self.package_sets: dict[str, tuple[list[str], list[str]]] = {}

    def add_package_set(self, name: str, packages: tuple[list[str], list[str]]) -> None:
        """Add a set of packages"""

        self.package_sets[name] = packages

    def install(self) -> bool:
        """Install the target"""

        click.clear()

        installed_package_sets: list[str] = []

        try:
            for (name, (package_set, command_set)) in self.package_sets.items():
                click.echo("")
                click.echo("Installing " + name)

                check_return(f"{self.package_handler} {' '.join(package_set)}")

                installed_package_sets.append(name)

                for command in command_set:
                    click.echo("Executing command: " + command)

                    check_return(command)
                    click.echo("Successfully executed command: " + command)
        except subprocess.CalledProcessError:
            click.echo("Failed to install package set due to error")
            if click.confirm("Remove all previously installed package sets?"):
                try:
                    for package_set in installed_package_sets:
                        check_return(
                            f"{self.package_handler} -R {' '.join(self.package_sets[package_set][0])}")
                except subprocess.CalledProcessError:
                    click.echo(
                        "Failed to remove package set, reinstall recommended or manually remove packages")
            return False

        return True
