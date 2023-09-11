"""Operations for the installer"""
#!/bin/python

from os import path

import click

from system import check_return, get_output


def get_branches() -> list[str]:
    """Get all branches of the current yadm repository"""
    blacklisted = ["HEAD", "main", "installer", "boilerplate"]

    branches = []

    # Get all remote branches and iterate through them
    for branch in get_output("yadm branch -r").split("\n"):
        # if the blacklist does not contain a part of the branch name, add it to the list
        if not any([blacklisted_branch in branch for blacklisted_branch in blacklisted]):
            branches.append(branch[9:])

    return branches


@click.command()
@click.option("--mode", prompt="Set operation mode (install, uninstall, list, create, delete, edit)", default="install", help="Set operation mode (install, uninstall, list, create, delete, edit)")
def main(mode: str) -> bool:
    """Entry point of the installer"""
    match mode:
        case "install":
            while True:
                try:
                    click.echo("Available target branches:")
                    branches = get_branches()
                    for i, branch in enumerate(branches):
                        click.echo(f"{i}: " + branch)
                    target_branch = branches[int(
                        click.prompt("Enter target branch"))]
                except IndexError:
                    click.echo("Invalid branch index.")
                else:
                    break

            commands = [
                "yadm checkout {}".format(target_branch),
                "~/.config/yadm/installer/scripts/init.sh",
                "~/.config/yadm/installer/scripts/pacman.sh"
            ]

            click.clear()

            for command in commands:
                click.echo("Executing command: " + command)
                click.echo("")

                if check_return(command):
                    click.echo("Successfully executed command: " + command)
                else:
                    click.echo("Failed to execute command: " + command)
                    return False


if __name__ == "__main__":
    if main():
        click.echo("Target configuration installed successfully.")
    else:
        click.echo("Target configuration installation failed.")
