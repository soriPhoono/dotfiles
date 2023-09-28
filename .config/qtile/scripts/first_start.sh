#!/bin/sh

xhost + local &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & # For authentication

picom &
dunst &
unclutter &
# Get random path from ~/.config/qtile/wallpapers directory using find
xgifwallpaper $(find ~/.config/qtile/wallpapers -type f | shuf -n1) &
# ~/.config/qtile/scripts/wallpaper.sh &

gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice' &
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' &
gsettings set org.gnome.desktop.interface gtk-theme 'Catppuccin-Mocha-Standard-Teal-dark' &

~/.local/bin/notifications/packages.sh &

easyeffects --gapplication-service &

discord --start-minimized &
radeon-profile &
