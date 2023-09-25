#!/usr/bin/env bash

color="$(zenity --color-selection)"
color_converted="$(echo "$color" | convert - -format '%[pixel:p{0,0}]' txt:- | tail -n 1 | cut -d ' ' -f 4)"
img="/tmp/${color}.png"

echo "$color" | wl-copy

convert -size 64x64 xc:"$color" "$img"
notify-send -i "$img" "${color} copied to clipboard"
