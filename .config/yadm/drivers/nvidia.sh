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
    esac
done

packages=(
    "nvidia-dkms"
    "nvidia-utils"
    "ocl-icd"
    "opencl-nvidia"
    "clinfo"
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

# Install packages
echo "Installing packages..."
paru -S --noconfirm --needed "${packages[@]}" >>/dev/null 
echo "Installed nvidia driver packages."

# Execute commands
for command in "${commands[@]}"; do
    eval "$command" >>/dev/null 
done
echo "Configured nvidia driver."
