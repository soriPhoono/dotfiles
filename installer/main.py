#!/usr/bin/env python3

import asyncio

from util import CURRENT_DIR, print_header, run_command, copy_config


async def main():
    '''Main function'''

    print('Installing...')
    print_header('Setting up pacman.conf and extra repositories...')
    copy_config('/etc/pacman.conf')
    await run_command([
        'sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com',
        'sudo pacman-key --lsign-key 3056513887B78AEB',
        'sudo pacman --noconfirm --needed -U "https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst" "https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst"',
        'echo -e "[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf'
    ])
    await run_command('sudo pacman --noconfirm -Syu')
    await run_command('sudo pacman --noconfirm --needed -S paru')
    copy_config('/etc/paru.conf')
    print_header('Installed pacman.conf and extra repositories')

    print_header('Setting up mirrorlist...')
    await run_command('paru --noconfirm --needed -S reflector rsync')
    copy_config('/etc/xdg/reflector/reflector.conf')
    await run_command('sudo systemctl enable --now reflector.timer')
    await run_command('sudo systemctl start reflector.service')

    print_header('Acquiring remaining dotfiles...')
    await run_command(f'git submodule update --init --recursive -- ../{CURRENT_DIR}')


if __name__ == '__main__':
    asyncio.run(main())
