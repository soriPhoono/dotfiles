#!/usr/bin/env bash

source "$HOME"/.local/bin/environment.sh

# Get current brightness (in %)
currentBrightness=$(brightnessctl i | awk '/Current brightness/ {gsub(/[(%)]/,""); print $NF}')

function send_notification {

    # Check if the current brightness is greater than or equal to 80
    if [[ $currentBrightness -ge 80 ]]; then
        # If it is, send a notification with the full brightness icon
        notify-send -i "$icon_brightness_full" -u low -r 10 "Brightness: ${currentBrightness}%"
    # If the current brightness is between 40 and 80 (inclusive)
    elif [[ $currentBrightness -ge 40 ]]; then
        # Send a notification with the half brightness icon
        notify-send -i "$icon_brightness_half" -u low -r 10 "Brightness: ${currentBrightness}%"
    # If the current brightness is less than 40
    else
        # Send a notification with the low brightness icon
        notify-send -i "$icon_brightness_low" -u low -r 10 "Brightness: ${currentBrightness}%"
    fi
}

case "$1" in
up)
    brightnessctl -q s +1%
    send_notification
    ;;
down)
    if [ "$currentBrightness" -eq 1 ]; then
        send_notification
    else
        brightnessctl -q s 1-%
        send_notification
    fi
    ;;
esac
