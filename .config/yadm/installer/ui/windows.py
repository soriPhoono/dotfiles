import abc
import curses

import widgets


class Window(abc.ABC):
    def __init__(self, x: int, y: int, width: int, height: int) -> None:
        self.inner: curses.window = curses.newwin(height, width, y, x)

    def draw(self) -> None:
        self.inner.clear()



        self.inner.noutrefresh()

    def update(self, key: int) -> None:
        pass


class MainWindow(Window):
    def __init__(self) -> None:
        super().__init__()

    def draw(self) -> None:
        super().draw()

    def update(self, key: int) -> None:
        super().update(key)
