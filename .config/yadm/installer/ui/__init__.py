import windows
import widgets

import abc


class Widget(abc.ABC):
    def __init__(self) -> None:
        self.parent: Window = None

    def draw(self) -> None:
        pass

    def update(self, key: int) -> None:
        pass


class Window(abc.ABC):
    def __init__(self) -> None:
        self.parent: Window = None
        self.children: list[Widget] = []

    def draw(self) -> None:
        for child in self.children:
            child.draw()

    def update(self, key: int) -> None:
        for child in self.children:
            child.update(key)
