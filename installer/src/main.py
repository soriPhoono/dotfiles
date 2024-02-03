'''Installer main module'''

import os
import os.path
import asyncio
import logging
import datetime

from argparse import ArgumentParser, Namespace
from yaml import safe_load

from utils import check_not_root, check_os_release


def parse_args() -> Namespace:
    '''Parse the command line arguments'''

    # Parse the command line arguments
    parser = ArgumentParser(
        prog='Installer',
        description='Installer for rice files targeting a NixOS',
        epilog='This program is licensed under the BSL-1.0 license'
    )

    parser.add_argument('-v', '--verbose', action='store_true',
                        help='Enable debug output')

    return parser.parse_args()


async def init_logger(debug: bool) -> bool:
    '''Initialize the logger'''

    # Create the log directory
    os.makedirs('logs', exist_ok=True)

    # Get logfile name
    logfile_prepend = datetime.datetime.now().strftime('%Y-%m-%d')
    _, _, logfile_files = os.walk("logs/")
    logfile_index = len(
        list(filter(lambda x: logfile_prepend in x, logfile_files)))
    logfile_name = f'logs/{logfile_prepend}{"" if logfile_index ==
                                            0 else f"_{logfile_index}"}.log'

    # Set up the logger
    logging.basicConfig(
        format='%(asctime)s - %(levelname)s - %(message)s',
        filename=logfile_name,
        encoding='utf-8',
        level=(logging.DEBUG if debug else logging.INFO),
    )

    return True


async def main():
    '''Main function of the installer'''

    # Load the metadata file
    try:
        with open('meta.yml', 'r', encoding='utf-8') as file:
            metadata = safe_load(file)
    except FileNotFoundError:
        logging.error('Installation failed: Missing metadata file')

    # Parse the command line arguments
    args = parse_args()

    # Initialize the installer
    if len(
        filter(
            lambda x: not x,
            await asyncio.gather(
                init_logger(os.getenv('USER') ==
                            metadata['Author']['Name'] or args.verbose),
                check_not_root(),
                check_os_release(metadata['Supported']),
            )
        )
    ) > 0:
        logging.critical('Installation failed: Aborting')

        return

    # Run the installer
    logging.info('Conditions verified: Starting installation')

    # Install dotfiles and system configuration
    logging.info('Installing dotfiles and system configuration')


if __name__ == '__main__':
    # Run the main function
    asyncio.run(main())
