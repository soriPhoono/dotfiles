import subprocess

import click


def check_return(command: str) -> bool:
    """Check the return code of a command"""
    return subprocess.run(command + " > /dev/null", shell=True).returncode == 0


def get_output(command: str) -> str:
    """Get the output of a command"""
    return subprocess.run(command, shell=True, capture_output=True).stdout.decode("utf-8")
