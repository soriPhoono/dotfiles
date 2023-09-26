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
paru -S --noconfirm --needed "${packages[@]}" >/dev/null
echo "Finished installing general tools"
