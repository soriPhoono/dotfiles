#!/bin/bash

# Path:             ~/.config/yadm/drivers/amd.sh
# Description:      Driver installation script for AMD graphics cards
# Author:           Sori Phoono <soriphoono@gmail.com>

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
    "mesa"
    "xf86-video-intel"
    "vulkan-intel"
)

if $MULTILIB; then
    packages+=("lib32-mesa" "lib32-vulkan-intel")
fi

paru -S --noconfirm --needed "${packages[@]}"

if $HWACCEL; then
    packages+=("intel-media-driver" "libva-utils" "ocl-icd" "intel-compute-runtime" "clinfo")

    if grep -q "LIBVA_DRIVER_NAME" /etc/environment >/dev/null; then
        sudo sed -i "s/LIBVA_DRIVER_NAME=.*/LIBVA_DRIVER_NAME=radeonsi/" /etc/environment
    else
        echo "LIBVA_DRIVER_NAME=iHD" | sudo tee -a /etc/environment >/dev/null
    fi
fi

paru -c --noconfirm >/dev/null
