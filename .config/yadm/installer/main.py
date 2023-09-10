"""Operations for the installer"""
#!/bin/python

from os import path
from asyncio import run

import click

from system import get_output as system
from models import Target


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
    match mode:
        case "install":
            click.echo("Available target branches:")
            for i, branch in enumerate(get_branches()):
                click.echo(f"{i}: " + branch)
            target_branch = click.prompt(
                "Enter target branch")

            system("yadm checkout {}".format(target_branch))

            return run(Target().install())


if __name__ == "__main__":
    if main():
        click.echo("Target configuration installed successfully.")
    else:
        click.echo("Target configuration installation failed.")
