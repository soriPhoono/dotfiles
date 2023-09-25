#!/usr/bin/env bash
# source: https://gitlab.com/luca.py/dotfiles/-/blob/main/home/.local/bin/scripts/passgen

source "$HOME"/.local/bin/environment.sh

passg=$(openssl rand -base64 $(($RANDOM % 6 + 15)))
echo "$passg" | wl-copy
notify-send -i "$icon_bell" "Generated Password copied to clipboard"
