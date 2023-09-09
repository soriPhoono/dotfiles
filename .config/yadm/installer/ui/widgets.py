import abc
import curses

import windows


class Widget(abc.ABC):
    def __init__(self, x: int, y: int, width: int, height: int, border: bool = False) -> None:
        self.parent: windows.Window = None

        self.x: int = x
        self.y: int = y
        self.width: int = width
        self.height: int = height

        self.visible = False

        self.border: bool = border

    def set_parent(self, parent: windows.Window) -> None:
        self.parent = parent

    def set_x(self, x: int) -> None:
        self.x = x

    def set_y(self, y: int) -> None:
        self.y = y

    def set_location(self, x: int, y: int) -> None:
        self.x = x
        self.y = y

    def set_width(self, width: int) -> None:
        self.width = width

    def set_height(self, height: int) -> None:
        self.height = height

    def set_size(self, width: int, height: int) -> None:
        self.width = width
        self.height = height

    def visible(self) -> bool:
        self.visible = not self.visible

    def is_visible(self) -> bool:
        return self.visible

    @abc.abstractmethod
    def draw(self, stdscr: curses.window) -> None:
        if self.border:
            stdscr.addstr(self.y, self.x, '┌' + '─' * (self.width - 2) + '┐')
            for i in range(self.height - 2):
                stdscr.addstr(self.y + i + 1, self.x, '│' +
                              ' ' * (self.width - 2) + '│')
            stdscr.addstr(self.y + self.height - 1, self.x,
                          '└' + '─' * (self.width - 2) + '┘')

    @abc.abstractmethod
    def update(self, key: int) -> None:
        pass


class Label(Widget):
    def __init__(self, x: int, y: int, width: int, height: int, text: str, border: bool = False) -> None:
        super().__init__(x, y, width, height, border)

        self.text: str = text

    def draw(self, stdscr: curses.window) -> None:
        super().draw(stdscr)

        stdscr.addstr(self.y + self.height // 2, self.x +
                      self.width // 2 - len(self.text) // 2, self.text)

    def update(self, key: int) -> None:
        pass


class Button(Widget):
    def __init__(self, x: int, y: int, width: int, height: int, text: str, border: bool = False) -> None:
        super().__init__(x, y, width, height, border)

        self.text: str = text
        self.is_selected: bool = False

    def draw(self, stdscr: curses.window) -> None:
        super().draw(stdscr)

        stdscr.addstr(self.y + self.height // 2, self.x +
                      self.width // 2 - len(self.text) // 2, self.text)
        
    def update(self, key: int) -> None:
        pass

class Input(Widget):
    def __init__(self, x: int, y: int, width: int, height: int, hint_text: str, border: bool = False, on_return: callable = None) -> None:
        super().__init__(x, y, width, height, border)

        self.hint_text: str = hint_text

        self.on_return: callable = on_return

    def on_return(self, on_return: callable = None) -> None:
        if on_return:
            self.on_return = on_return

    def draw(self, stdscr: curses.window) -> None:
        super().draw(stdscr)

        stdscr.addstr(self.y + self.height // 2, self.x +
                      self.width // 2 - len(self.hint_text) // 2, self.hint_text)

    def update(self, key: int) -> None:
        if key == curses.KEY_ENTER:
            self.on_return()
