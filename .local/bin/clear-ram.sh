#!/usr/bin/env bash

source "$HOME"/.local/bin/environment.sh

password="$(zenity --password)"

echo "$password" | sudo -S sh -c 'echo 3 > /proc/sys/vm/drop_caches'
notify-send -i "$icon_memory" "Memory cache flushed successfully"
