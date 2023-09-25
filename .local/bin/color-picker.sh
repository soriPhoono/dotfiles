#!/bin/bash

color_picker="$(grim -g "$(slurp -p -b 00000000 -c 00000000)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:- | tail -n 1 | cut -d ' ' -f 4)"
image="/tmp/${color_picker}".png

echo "$color_picker" | tr -d "\n" | wl-copy
convert -size 64x64 xc:"$color_picker" "$image"
notify-send -u low -r 69 -i "$image" "${color_picker} copied to clipboard"
