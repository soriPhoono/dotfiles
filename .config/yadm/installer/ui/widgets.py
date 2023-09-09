import abc

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
    def draw(self) -> None:
        pass

    @abc.abstractmethod
    def update(self, key: int) -> None:
        pass
