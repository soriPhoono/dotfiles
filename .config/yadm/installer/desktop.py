import abc
import subprocess

import click

from system import check_return


class InstallerTarget:
    """Base class for installer targets"""

    def __init__(self) -> None:
        super().__init__()

        self.package_handler: str = "sudo pacman -S --noconfirm --needed"

        self.package_sets: list[tuple[list[str], list[str]]] = []

    def add_package_set(self, packages: tuple[list[str], list[str]]) -> None:
        """Add a set of packages"""

        self.package_sets.append(packages)

    def install(self) -> bool:
        """Install the target"""

        click.clear()

        installed_package_sets = []

        try:
            for (package_set, command_set) in self.package_sets:
                click.echo("")
                click.echo("Installing package set: " + package_set)

                check_return(f"{self.package_handler} {' '.join(package_set)}")

                installed_package_sets.append(package_set)

                for command in command_set:
                    click.echo("Executing command: " + command)
                    click.echo("")

                    check_return(command)
                    click.echo("Successfully executed command: " + command)
        except subprocess.ChildProcessError:
            click.echo("Failed to install package set due to error")
            if click.confirm("Remove all previously installed package sets?"):
                try:
                    for package_set in installed_package_sets:
                        check_return(
                            f"{self.package_handler} -R {' '.join(package_set)}")
                except subprocess.ChildProcessError:
                    click.echo("Failed to remove package set")
            return False


def main() -> InstallerTarget:
    return False
