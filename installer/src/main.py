#!/usr/bin/env python

'''Main file of the installer'''

import os
import asyncio

from utils import run_command, get_output


SUPPORTED_DISTROS = 'nixos'


async def check_root() -> bool:
    '''Check if the user is root'''

    if os.geteuid() != 0:
        print('You must be root to run this script')
        return False

    return True


async def check_os_release() -> bool:
    '''Check if the system is of a supported distribution'''

    # Get the distribution name
    distro = await get_output('cat /etc/os-release')
    # Check if the distribution is supported
    for line in filter(lambda x: x.startswith('NAME='), distro.splitlines()):
        if line.split('=')[1].replace('"', '').lower() == SUPPORTED_DISTROS:
            return True

    print('Your distribution is not supported')

    return False


async def main():
    '''Main function of the installer'''

    # Check execution conditions
    if not (await check_root() and await check_os_release()):
        return

    pass


if __name__ == '__main__':
    asyncio.run(main())
