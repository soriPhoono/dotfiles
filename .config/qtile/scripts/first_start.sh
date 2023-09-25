#!/bin/sh

xhost + local &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & # For authentication

redshift &
picom &

unclutter &
dunst &

~/.local/bin/notifications/packages.sh &

easyeffects --gapplication-service &

discord --start-minimized &
radeon-profile &
