#!/bin/python

import curses

from curses import wrapper

import ui

EXIT_KEY = ord('q')


class App:
    def __init__(self) -> None:
        self.stdscr: curses.window = curses.initscr()

        curses.noecho()
        curses.cbreak()
        self.stdscr.keypad(True)

        curses.curs_set(0)

    def __del__(self) -> None:
        curses.curs_set(1)

        self.stdscr.keypad(False)
        curses.nocbreak()
        curses.echo()

        curses.endwin()

    def run(self) -> None:
        while True:
            self.stdscr.erase()

            self.stdscr.addstr(0, 0, 'Hello, world!')

            self.stdscr.noutrefresh()
            curses.doupdate()

            match self.stdscr.getch():
                case EXIT_KEY:
                    break


App().run()
