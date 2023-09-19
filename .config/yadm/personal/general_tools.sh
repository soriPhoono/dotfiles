#!/bin/bash

# Path:         ~/.config/yadm/personal/bootstrap

packages=(
    "telegram-desktop"
    "signal-desktop"
    "discord"
    "betterdiscordctl-git"
    "python-spotdl"
)

echo "Installing packages..."
paru -S --noconfirm --needed "$packages[@]" >>/dev/null 2>&1
echo "Finished installing communication tools"
