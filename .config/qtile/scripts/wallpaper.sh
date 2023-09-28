#!/bin/bash

source "$HOME/.local/bin/environment.sh"

# Get all wallpapers
wallpapers=$(find ~/.config/qtile/wallpapers/ -type f)
while true; do

  # Get random wallpaper
  current_wallpaper=$(shuf -n 1 <<<$wallpapers)
  
  xgifwallpaper $current_wallpaper &
  notify-send -i "$icon_screenshot" -u normal -r 60 "Updated wallpaper" "New wallpaper: $(basename $current_wallpaper)"

  sleep 1h
done
