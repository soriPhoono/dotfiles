# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import layout
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.hook import subscribe

import os
import math
from subprocess import call

import theme

home = os.path.expanduser('~')
monitor_count = 3

mod = "mod4"

terminal = os.getenv("TERM") or "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal + " -e " + editor

browser = os.getenv("BROWSER") or "firefox"

# TODO: adjust hotkeys
keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Control system
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod], "p", lazy.spawn(home + "/.config/rofi/powermenu/type-6/powermenu.sh"),
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
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "Left", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "Right", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "Down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod, "control"], "n", lazy.layout.normalize(),
        desc="Reset all window sizes"),
    Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle fullscreen"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "a", lazy.spawn(
        home + "/.config/rofi/launchers/type-6/launcher.sh"), desc="Launch rofi"),
    Key([mod], "e", lazy.spawn("pcmanfm"), desc="Launch file manager"),
    Key([mod], "F4", lazy.spawn("flameshot gui"), desc="Launch xkill"),

    # Volume control
    Key([], "XF86AudioRaiseVolume", lazy.spawn(
        f"pactl set-sink-volume @DEFAULT_SINK@ +5%"), desc="Increase volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn(
        f"pactl set-sink-volume @DEFAULT_SINK@ -5%"), desc="Decrease volume"),
    Key([], "XF86AudioMute", lazy.spawn(
        f"pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="Mute volume"),
    Key([], "XF86AudioMicMute", lazy.spawn(
        f"pactl set-source-mute @DEFAULT_SOURCE@ toggle"), desc="Mute microphone"),
    Key([], "XF86AudioPlay", lazy.spawn(
        "playerctl play-pause"), desc="Play/Pause"),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="Next track"),
    Key([], "XF86AudioPrev", lazy.spawn(
        "playerctl previous"), desc="Previous track"),

    # Application launchers
    Key([mod], "b", lazy.spawn(browser), desc="Launch browser"),
    Key([mod], "c", lazy.spawn("code"), desc="Launch VSCode"),
    Key([mod], "d", lazy.spawn("discord --start-minimized"), desc="Launch Discord"),
    Key([mod], "m", lazy.spawn("exaile"), desc="Launch Spotify"),
]

screens = [
    Screen(
        wallpaper=theme.wallpaper,
        wallpaper_mode="fill",
    ),
    Screen(
        wallpaper=theme.wallpaper,
        wallpaper_mode="fill",
    ),
    Screen(
        wallpaper=theme.wallpaper,
        wallpaper_mode="fill",
    ),
]

layouts = [
    layout.Spiral(border_focus=theme.border_focus,
                  border_normal=theme.border_normal,
                  border_width=theme.border_width,
                  margin=theme.useless_gap),
]

groups = [Group(i, layout="stack",
                screen_affinity=int(math.floor(int(i) / monitor_count))) for i in "123456"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(
                    i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = True
floating_layout = layout.Floating(
    border_focus=theme.border_focus,
    border_normal=theme.border_normal,
    border_width=theme.border_width,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


@subscribe.startup_once
def init():
    call(["sh", f"{home}/.config/qtile/scripts/first_start.sh"])


@subscribe.startup_complete
def reload():
    call(["sh", f"{home}/.config/qtile/scripts/autostart.sh"])
