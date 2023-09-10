import subprocess

import asyncio
from asyncio import subprocess as asyncio_subprocess

import click


def get_output(command: str) -> str:
    """Get the output of a command"""
    return subprocess.check_output(command, shell=True).decode("utf-8")


def spawn_process(command: str) -> bool:
    """Spawn a subprocess running a command"""
    click.clear()
    click.echo("Running command: {}".format(command))
    click.echo("")

    process = subprocess.Popen(
        command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    stdout, stderr = process.communicate()

    if stdout:
        for line in stdout.decode("utf-8").split("\n"):
            click.echo(line)

    if stderr:
        click.echo("Error: {}".format(stderr.decode("utf-8")))
        return False

    return True


def spawn_processes(commands: list[str]) -> bool:
    """Spawn multiple subprocesses running commands"""
    for command in commands:
        if not spawn_process(command):
            return False

    return True


async def spawn_process_async(command: str) -> bool:
    """Spawn a subprocess running a command and await the result"""
    click.clear()
    click.echo("Running command: {}".format(command))
    click.echo("")

    process = await asyncio_subprocess.create_subprocess_shell(
        command, stdout=asyncio_subprocess.PIPE, stderr=asyncio_subprocess.PIPE
    )

    stdout, stderr = await process.communicate()

    if stdout:
        for line in stdout.decode("utf-8").split("\n"):
            click.echo(line)

    if stderr:
        click.echo("Error: {}".format(stderr.decode("utf-8")))
        return False

    return True


async def spawn_processes_async(commands: list[str]) -> bool:
    """Spawn multiple subprocesses running commands and await the results"""
    for command in commands:
        if not await spawn_process(command):
            return False

    return True
