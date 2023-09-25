#!/usr/bin/env bash

# Needed packages: pactl
# Usage:
# Write path to this script in your WM config.
#
# Example for i3wm / sway:
# XF86AudioRaiseVolume  exec ~/.local/bin/notifications/volume.sh up
# XF86AudioLowerVolume  exec ~/.local/bin/notifications/volume.sh down
# XF86AudioMute         exec ~/.local/bin/notifications/volume.sh mute

source $HOME/.local/bin/environment.sh

# Get current volume and mute status
currentVol="$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -n1 | tr -d '%')"
isMute="$(pactl get-sink-mute @DEFAULT_SINK@ | sed 's/Mute: //')"

# Send notification based on current volume and mute status
if [[ "$isMute" == "yes" ]]; then
    notify-send -i "$icon_volume_mute" -u low -r 20 "Volume: ${currentVol}%"
elif [[ "$currentVol" -ge 80 ]]; then
    notify-send -i "$icon_volume_high" -u low -r 20 "Volume: ${currentVol}%"
elif [[ "$currentVol" -ge 1 ]]; then
    notify-send -i "$icon_volume_half" -u low -r 20 "Volume: ${currentVol}%"
else
    notify-send -i "$icon_volume_mute" -u low -r 20 "Volume: ${currentVol}%"
fi

# Adjust volume based on user input
case "$1" in
up)
    if [[ "$currentVol" -lt 100 ]]; then
        pactl set-sink-volume @DEFAULT_SINK@ +5%
    fi
    ;;
down)
    pactl set-sink-volume @DEFAULT_SINK@ -5%
    ;;
mute)
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    ;;
esac

# Send notification again to update volume display
send_notify() {
    current_vol="$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -n1 | tr -d '%')"
    isMute="$(pactl get-sink-mute @DEFAULT_SINK@ | sed 's/Mute: //')"

    if [[ "$isMute" == "yes" ]]; then
        notify-send -i "$icon_volume_mute" -u low -r 20 "Volume: ${current_vol}%"
    elif [[ "$currentVol" -ge 80 ]]; then
        notify-send -i "$icon_volume_high" -u low -r 20 "Volume: ${current_vol}%"
    elif [[ "$currentVol" -ge 1 ]]; then
        notify-send -i "$icon_volume_half" -u low -r 20 "Volume: ${current_vol}%"
    else
        notify-send -i "$icon_volume_mute" -u low -r 20 "Volume: ${current_vol}%"
    fi
}

send_notify
