'''Utility functions for the installer'''

import os
import asyncio
import logging


async def check_not_root() -> bool:
    '''Check if the user is root'''

    # Check if the user is root
    return os.getuid() != 0


async def check_os_release(supported_distros: list[str]) -> bool:
    '''Check if the system is of a supported distribution'''

    success, output = await run_command('cat /etc/os-release', True)

    # Check if the distribution is supported
    return success and next(filter(
        lambda x: x.startswith('NAME='),
        output.splitlines()
    )).split('=')[1].replace('"', '').lower() in supported_distros


async def run_command(cmd: str, get_output: bool = False) -> tuple[bool, str]:
    '''Execute a command with the optional return of its output'''

    proc = await asyncio.create_subprocess_shell(
        cmd,
        stdout=asyncio.subprocess.PIPE if get_output else asyncio.subprocess.DEVNULL,
        stderr=asyncio.subprocess.PIPE
    )

    stdout, stderr = await proc.communicate()

    logging.debug('Command: %s', cmd)
    logging.debug('Return code: %s', proc.returncode)

    if proc.returncode != 0:
        logging.error('Error:\n%s', '\n'.join(map(
            lambda x: f'\t{x}', stderr.decode().splitlines())))

        return False, stderr.decode()

    return True, stdout.decode()
