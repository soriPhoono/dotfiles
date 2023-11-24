#!/bin/bash

# Path:         ~/.config/yadm/drivers/nvidia.sh
# Description:  Driver installation script for Nvidia graphics cards
# Author:       Sori Phoono <soriphoono@gmail.com>

MULTILIB=false
for arg in "$@"; do
    case "$arg" in
    -m | --multilib)
        MULTILIB=true
        ;;
    --hwaccel)
        HWACCEL=true
        ;;
    esac
done

packages=(
    "nvidia-dkms"
    "nvidia-utils"
    "prime-run"
)

commands=(
    "sudo sed -i \"kms //g\" /etc/mkinitcpio.conf"
    "sudo mkinitcpio -P"
    "sudo sed -i '/^options/ s/$/ nvidia-drm.modeset=1/' /boot/loader/entries/*.conf"
    "sudo modprobe nvidia_uvm"
)

if $MULTILIB; then
    packages+=("lib32-nvidia-utils")
fi

if $HWACCEL; then
    packages+=("ocl-icd" "opencl-nvidia" "clinfo")

    read -p "Install CUDA? [y/n]" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        packages+=("cuda")
    fi

    if $MULTILIB; then
        packages+=("lib32-opencl-nvidia")
    fi
fi

# Install packages
echo "Installing packages..."
paru -S --noconfirm --needed "${packages[@]}"
echo "Installed nvidia driver packages."

# Execute commands
for command in "${commands[@]}"; do
    eval "$command" >/dev/null
done
echo "Configured nvidia driver."

paru -c --noconfirm >/dev/null
