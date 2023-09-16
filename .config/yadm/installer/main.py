"""Operations for the installer"""
import abc
import subprocess

import click

from system import check_return, get_output


def install_branch(branch: str) -> bool:
    """Install the target branch"""
    commands = [
        f"yadm checkout {branch}",
        "yadm submodule init && yadm submodule update",
        "~/.config/yadm/installer/scripts/pacman.sh",
    ]

    click.clear()

    for command in commands:
        click.echo("Executing command: " + command)
        click.echo("")

        try:
            check_return(command)
            click.echo("Successfully executed command: " + command)
        except subprocess.CalledProcessError:
            click.echo("Failed to execute command: " + command)
            return False

    import desktop

    installer_target = desktop.main()
    installer_target.install()

    return True


def get_branches() -> list[str]:
    """Get all branches of the current yadm repository"""
    blacklisted = ["HEAD", "main", "installer", "boilerplate"]

    branches = []

    # Get all remote branches and iterate through them
    for branch in get_output("yadm branch -r").split("\n"):
        # if the blacklist does not contain a part of the branch name,
        # add it to the list
        if not (len(branch) == 0
                or any(blk_branch in branch for blk_branch in blacklisted)):
            branches.append(branch[9:])

    return branches


@click.command()
@click.option(
    "--mode",
    prompt="Set operation mode (i, u, l, c, d, e)",
    default="install",
    help="Set operation mode (i, u, l, c, d, e)")
def main(mode: str):
    """Entry point of the installer"""
    match mode:
        case "install":
            click.clear()

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

            install_branch(target_branch)

    return False


if __name__ == "__main__":
    main()
