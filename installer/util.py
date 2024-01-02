import os
import getpass

from os.path import dirname, abspath

CURRENT_DIR = dirname(abspath(__file__))


def print_header(text: str) -> None:
    '''Print a header'''

    print('')
    print(f'== {text} ==')


def confirm(message: str, default: bool | None = None) -> bool:
    '''Ask the user for confirmation'''

    while True:
        if default is None:
            answer = input(f'{message} [y/n] ')
        elif default:
            answer = input(f'{message} [Y/n] ')
        else:
            answer = input(f'{message} [y/N] ')

        if answer.lower() in ('y', 'yes'):
            return True
        elif answer.lower() in ('n', 'no'):
            return False
        elif answer == '' and default is not None:
            return default


async def run_command(command: str | list[str], output: bool = False) -> bool:
    '''Run a command in the shell'''

    from asyncio.subprocess import create_subprocess_shell, PIPE, DEVNULL

    if command is list[str]:
        access = PIPE if output else DEVNULL
        process = await create_subprocess_shell(' && '.join(command), stdin=access, stdout=access, stderr=access)

        await process.communicate()

        return process.returncode == 0
    elif command is str:
        access = PIPE if output else DEVNULL
        process = await create_subprocess_shell(command, stdin=access, stdout=access, stderr=access)

        await process.communicate()

        return process.returncode == 0


async def backup_file(path: str, preserve: bool = False) -> bool:
    '''Create a backup of a file or restore from backup if that backup exists'''

    if not os.path.exists(path):
        raise FileNotFoundError(f'File {path} does not exist, cannot backup!')

    permissions = '' if path.startswith('~') or path.startswith(
        f'/home/{getpass.getuser()}') else 'sudo '

    if not os.path.exists(f'{path}.bak'):
        if preserve:
            await run_command(f'{permissions}cp {path} {path}.bak')
        else:
            await run_command(f'{permissions}mv {path} {path}.bak')

        print(f'Created backup of {path} at {path}.bak')

        return True
    else:
        print(f'Backup of {path} already exists')

        return True


async def copy_config(path: str, backup: bool = True) -> bool:
    '''Copy a config file to its destination'''

    if not os.path.exists(f'{CURRENT_DIR}/root/{path}'):
        raise FileNotFoundError(
            f'File {CURRENT_DIR}/root/{path} does not exist, cannot copy!')

    if backup:
        backup_file(path)

    permissions = '' if path.startswith('~') or path.startswith(
        f'/home/{getpass.getuser()}') else 'sudo '

    await run_command(f'{permissions}cp {CURRENT_DIR}/root/{path} {path}')
