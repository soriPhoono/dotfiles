#!/usr/bin/env bash

export DISPLAY=:0
export XAUTHORITY=/home/shved/.Xauthority
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

source $HOME/.local/bin/environment.sh

if [ "$ACTION" = "add" ]; then
    if [ -d /sys/class/power_supply ]; then
        notify-send -i "$icon_mtp_laptop" -u normal -r 50 "Android device connected"
    else
        notify-send -i "$icon_mtp_desktop" -u normal -r 50 "Android device connected"
    fi
else
    if [ -d /sys/class/power_supply ]; then
        notify-send -i "$icon_mtp_laptop" -u normal -r 50 "Android device disconnected"
    else
        notify-send -i "$icon_mtp_desktop" -u normal -r 50 "Android device disconnected"
    fi
fi
