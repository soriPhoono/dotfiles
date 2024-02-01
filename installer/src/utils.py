'''Utility functions for the installer'''

import asyncio


async def run_command(cmd: str) -> None:
    '''Run a command'''

    proc = await asyncio.create_subprocess_shell(cmd)

    await proc.communicate()


async def get_output(cmd: str) -> str:
    '''Get output of a command'''

    proc = await asyncio.create_subprocess_shell(
        cmd,
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.PIPE
    )

    stdout, _ = await proc.communicate()

    return stdout.decode().strip()
