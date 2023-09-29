#!/bin/sh

xhost + local &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & # For authentication

picom &
dunst &
unclutter &
~/.config/qtile/scripts/wallpaper.sh &

gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice' &
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' &
gsettings set org.gnome.desktop.interface gtk-theme 'Catppuccin-Mocha-Standard-Teal-dark' &

xidlehook \
    --not-when-fullscreen \
    --not-when-audio \
    --detect-sleep \
    --timer 600 \
        'betterlockscreen -l dimblur --span' \
        '' \
    --timer 900 \
        'systemctl suspend' \
        '' &

~/.local/bin/notifications/packages.sh &

easyeffects --gapplication-service &

discord --start-minimized &
radeon-profile &
