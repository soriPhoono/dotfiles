#!/usr/bin/env bash

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

source $HOME/.local/bin/environment.sh

batteryCharging=$1
batteryCurrentCapacity=$(acpi -b | grep "Battery 0" | grep -P -o '[0-9]+(?=%)')

if [ "$batteryCharging" -eq 1 ]; then
    notify-send -i "$icon_battery_charging" -u low -r 40 "Charging" "${batteryCurrentCapacity}% charged"
elif [ "$batteryCharging" -eq 0 ]; then
    notify-send -i "$icon_battery" -u low -r 40 "Discharging" "${batteryCurrentCapacity}% left"
fi
