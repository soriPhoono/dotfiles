#!/bin/bash

# Path:             ~/.config/yadm/drivers/amd.sh
# Description:      Driver installation script for AMD graphics cards
# Author:           Sori Phoono <soriphoono@gmail.com>

MULTILIB=false
DISCRETE=false
for arg in "$@"; do
    case "$arg" in
    -m | --multilib)
        MULTILIB=true
        ;;
    -d | --discrete)
        DISCRETE=true
        ;;
    esac
done

packages=(
    "mesa"
    "xf86-video-intel"
    "vulkan-intel"
    "intel-media-driver"
    "libva-utils"
    "ocl-icd"
    "opencl-rusticl-mesa"
    "clinfo"
)

if $MULTILIB; then
    packages+=("lib32-mesa" "lib32-vulkan-intel" "lib32-libva-mesa-driver" "lib32-ocl-icd" "lib32-opencl-rusticl-mesa")
fi

paru -S --noconfirm --needed "${packages[@]}" >>/dev/null 2>&1

if grep -i "LIBVA_DRIVER_NAME" /etc/environment >/dev/null; then
    sudo sed -i "s/LIBVA_DRIVER_NAME=.*/LIBVA_DRIVER_NAME=radeonsi/" /etc/environment
else
    sudo tee -a /etc/environment >/dev/null 2>&1 <<EOF
LIBVA_DRIVER_NAME=radeonsi
EOF
fi
