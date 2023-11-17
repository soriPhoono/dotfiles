#!/bin/bash

# Path:         ~/.config/yadm/personal/bootstrap
# Description:  Bootstrap script for personal environment
# Author:       Sori Phoono <soriphoono@gmail.com>

packages=(
	"discord"              # Discord desktop client
	"betterdiscordctl-git" # BetterDiscord installer
	"python-spotdl"        # Spotify downloader (also installes youtube-dl as dependency) (AUR)
)

echo "Installing packages..."
paru -S --noconfirm --needed "${packages[@]}"
echo "Finished installing general tools"

echo "Remember to setup betterdiscord after discord's first launch"

paru -c --noconfirm >/dev/null
