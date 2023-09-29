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
    --hwaccel)
        HWACCEL=true
        ;;
    esac
done

packages=(
    "mesa"
    "xf86-video-amdgpu"
    "vulkan-radeon"
)

commands=()

if $MULTILIB; then
    packages+=("lib32-mesa" "lib32-vulkan-radeon")
fi

if $HWACCEL; then
    packages+=("libva-mesa-driver" "libva-utils" "ocl-icd" "opencl-rusticl-mesa" "clinfo")

    read -p "Install ROCM runtime? [y/n]" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        packages+=("rocm-opencl-runtime" "rocm-hip-runtime")
    fi

    if $MULTILIB; then
        packages+=("lib32-libva-mesa-driver" "lib32-opencl-rusticl-mesa")
    fi

    if grep -q "LIBVA_DRIVER_NAME" /etc/environment >/dev/null; then
        commands+=("sudo sed -i 's/LIBVA_DRIVER_NAME=.*/LIBVA_DRIVER_NAME=radeonsi/' /etc/environment")
    else
        commands+=("echo 'LIBVA_DRIVER_NAME=radeonsi' | sudo tee -a /etc/environment >/dev/null")
    fi

    if grep -q "VDPAU_DRIVER" /etc/environment >/dev/null; then
        commands+=("sudo sed -i 's/VDPAU_DRIVER=.*/VDPAU_DRIVER=radeonsi/' /etc/environment")
    else
        commands+=("echo 'VDPAU_DRIVER=radeonsi' | sudo tee -a /etc/environment >/dev/null")
    fi
fi

if $DISCRETE; then
    packages+=("radeon-profile-daemon-git" "radeon-profile-git" "amdgpu-pro-oglp" "vulkan-amdgpu-pro" "amf-amdgpu-pro")
    commands+=("sudo systemctl enable radeon-profile-daemon")

    if $MULTILIB; then
        packages+=("lib32-amdgpu-pro-oglp" "lib32-vulkan-amdgpu-pro")
    fi

    if grep -q "VK_ICD_FILENAMES" /etc/environment >/dev/null; then
        commands+=("sudo sed -i 's/VK_ICD_FILENAMES=.*/VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i86.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json/' /etc/environment")
    else
        commands+=("echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i86.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json' | sudo tee -a /etc/environment >/dev/null")
    fi
fi

echo "Installing packages..."
paru -S --noconfirm --needed "${packages[@]}"
for command in "${commands[@]}"; do
    eval "$command" >/dev/null
done
echo "Installed amd driver packages."

paru -c --noconfirm >/dev/null
