#!/usr/bin/env bash

source "$HOME"/.local/bin/environment.sh

sudo -A sh -c 'echo 3 > /proc/sys/vm/drop_caches'
sudo swapoff -a && sudo swapon -a

notify-send -i "$icon_memory" "Memory cache flushed successfully"
