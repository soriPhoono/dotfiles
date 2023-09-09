import abc

import widgets

class Window(abc.ABC):
    def __init__(self) -> None:
        self.parent: Window = None
        self.children: list[widgets.Widget] = []

    def draw(self) -> None:
        for child in self.children:
            child.draw()

    def update(self, key: int) -> None:
        for child in self.children:
            child.update(key)


class MainWindow():
    def __init__(self) -> None:
        pass

    def draw(self) -> None:
        pass

    def update(self, key: int) -> None:
        pass
