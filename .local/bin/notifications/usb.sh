#!/usr/bin/env bash

export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

source $HOME/.local/bin/environment.sh

icon="$HOME/.local/bin/notifications/icons/flash-drive.png"
flashDriveName=$(lsblk -o name,model | grep sda | awk '{print $2}')

if [ "$ACTION" == "add" ]; then
    message="USB storage connected"
else
    message="USB storage disconnected"
fi

notify-send -i "$icon_usb_drive" -r 50 "$flashDriveName $message"
