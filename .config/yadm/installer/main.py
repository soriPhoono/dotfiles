#!/bin/python

import curses
from curses import wrapper


class App:
    def __init__(self) -> None:
        self.exit_key = ord('q')

        pass

    def run(self, stdscr: curses.window) -> None:
        curses.noecho()
        curses.cbreak()
        curses.curs_set(0)
        stdscr.keypad(True)

        while True:
            stdscr.erase()

            stdscr.addstr(0, 0, 'Hello, world!')

            stdscr.refresh()

            match stdscr.getch():
                case self.exit_key:
                    break


wrapper(App().run)
