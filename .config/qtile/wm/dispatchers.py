import os
from os import path

from libqtile.config import Key
from libqtile.lazy import lazy

home = path.expanduser('~')
terminal = os.getenv("TERM", "alacritty")
browser = os.getenv("BROWSER", "firefox")

mod = "mod4"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Control system
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod], "p", lazy.spawn(home + "/.config/rofi/launchers/powermenu/powermenu.sh"),
        desc="Launch rofi powermenu"),
    # Switch between windows
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle fullscreen"),
    # Toggle between different layouts as defined below
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "a", lazy.spawn(
        home + "/.config/rofi/launchers/applauncher/launcher.sh"), desc="Launch rofi"),
    Key([mod], "e", lazy.spawn("pcmanfm"), desc="Launch file manager"),
    Key([mod], "F4", lazy.spawn("flameshot gui"), desc="Launch xkill"),

    # Volume control
    Key([], "XF86AudioRaiseVolume", lazy.spawn(
        f"{home}/.local/bin/notifications/volume.sh up"), desc="Increase volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn(
        f"{home}/.local/bin/notifications/volume.sh down"), desc="Decrease volume"),
    Key([], "XF86AudioMute", lazy.spawn(
        f"{home}/.local/bin/notifications/volume.sh mute"), desc="Mute volume"),
    Key([], "XF86AudioMicMute", lazy.spawn(
        f"{home}/.local/bin/notifications/microphone.sh toggle"), desc="Mute microphone"),
    Key([], "XF86AudioPlay", lazy.spawn(
        "playerctl play-pause"), desc="Play/Pause"),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="Next track"),
    Key([], "XF86AudioPrev", lazy.spawn(
        "playerctl previous"), desc="Previous track"),

    Key([], "XF86MonBrightnessUp", lazy.spawn(
        f"{home}/.local/bin/notifications/brightness.sh up"), desc="Increase brightness"),
    Key([], "XF86MonBrightnessDown", lazy.spawn(
        f"{home}/.local/bin/notifications/brightness.sh down"), desc="Decrease brightness"),

    # Application launchers
    Key([mod], "b", lazy.spawn(browser), desc="Launch browser"),
    Key([mod], "c", lazy.spawn("code"), desc="Launch VSCode"),
    Key([mod], "d", lazy.spawn("discord"), desc="Launch Discord"),
    Key([mod], "s", lazy.spawn("spotify"), desc="Launch Spotify music player"),
    Key([mod], "m", lazy.spawn("exaile"), desc="Launch music player"),
]
