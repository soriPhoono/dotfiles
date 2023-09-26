#!/bin/bash

# Path:         ~/.config/yadm/personal/bootstrap
# Description:  Bootstrap script for personal environment
# Author:       Sori Phoono <soriphoono@gmail.com>

packages=(
    "telegram-desktop"     # Telegram desktop client
    "signal-desktop"       # Signal desktop client
    "discord"              # Discord desktop client
    "betterdiscordctl-git" # BetterDiscord installer
    "python-spotdl"        # Spotify downloader (also installes youtube-dl as dependency) (AUR)
)

echo "Installing packages..."
paru -S --noconfirm --needed "${packages[@]}"
echo "Finished installing general tools"

echo "Remember to setup betterdiscord after discord's first launch"
echo "\t1. Open discord"
echo "\t2. betterdiscordctl install"
echo "\t3. Restart discord"
echo "\t4. enable extensions/themes"

paru -c --noconfirm >/dev/null
