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


class MainWindow(Window):
    def __init__(self) -> None:
        super().__init__()

    def draw(self) -> None:
        super().draw()

    def update(self, key: int) -> None:
        super().update(key)
