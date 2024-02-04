'''Utility functions for the installer'''

import os
import logging
import subprocess


def check_not_root() -> bool:
    '''Check if the user is root'''

    # Check if the user is root
    return os.getuid() != 0


def check_os_release(supported_distros: list[str]) -> bool:
    '''Check if the system is of a supported distribution'''

    success, output = run_command('cat /etc/os-release', True)

    # Check if the distribution is supported
    return success and next(filter(
        lambda x: x.startswith('NAME='),
        output.splitlines()
    )).split('=')[1].replace('"', '').lower() in supported_distros


def run_command(cmd: str, get_output: bool = True) -> tuple[bool, str]:
    '''Execute a command with the optional return of its output'''

    proc = subprocess.run(
        cmd,
        shell=True,
        stdout=subprocess.PIPE if get_output else subprocess.DEVNULL,
        stderr=subprocess.PIPE,
        check=False,
        encoding='utf-8'
    )

    stdout = proc.stdout
    stderr = proc.stderr

    logging.debug('Command: %s', cmd)
    logging.debug('Return code: %s', proc.returncode)

    return proc.returncode == 0, stdout if get_output else stderr
