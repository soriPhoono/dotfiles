#!/usr/bin/env bash

# Imports
source ./src/util/default.sh

# Install drivers

info "Installing mesa and amdgpu drivers"

install_packages mesa lib32-mesa xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon

# Install opencl https://wiki.archlinux.org/title/GPGPU

info "Installing opencl on mesa"

install_packages opencl-rusticl-mesa lib32-opencl-rusticl-mesa ocl-icd lib32-ocl-icd clinfo

if ! grep -q "LIBVA_DRIVER_NAME" /etc/environment; then
	echo "LIBVA_DRIVER_NAME=radeonsi" | sudo tee -a /etc/environment
fi

if ! grep -q "VDPAU_DRIVER" /etc/environment; then
	echo "VDPAU_DRIVER=radeonsi" | sudo tee -a /etc/environment
fi
