#!/bin/bash

# Path:         ~/.config/yadm/drivers/virtual.sh
# Desc:         Install virtual machine drivers
# Author:       Sori Phoono <soriphoono@gmail.com>

MULTILIB=false
for arg in "$@"; do
    case "$arg" in
    "--multilib")
        MULTILIB=true
        ;;
    esac
done

packages=(
    "virtualbox-guest-utils"
)

commands=(
    "sudo systemctl enable vboxservice.service"
)

echo "Installing packages..."
paru -S --noconfirm --needed "${packages[@]}" >/dev/null
for command in "${commands[@]}"; do
    eval "$command" >/dev/null
done
echo "Installed virtual machine drivers."
