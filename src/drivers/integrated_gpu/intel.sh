#!/usr/bin/env bash

# Imports
source ./src/util/default.sh

# Install drivers

info "Installing mesa and intel drivers"

install_packages mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver libvdpau-va-gl

# Install opencl https://wiki.archlinux.org/title/GPGPU

info "Installing opencl on mesa"

install_packages opencl-rusticl-mesa lib32-opencl-rusticl-mesa ocl-icd lib32-ocl-icd clinfo

if ! grep -q "LIBVA_DRIVER_NAME" /etc/environment; then
	echo "LIBVA_DRIVER_NAME=iHD" | sudo tee -a /etc/environment
fi

if ! grep -q "VDPAU_DRIVER" /etc/environment; then
	echo "VDPAU_DRIVER=va_gl" | sudo tee -a /etc/environment
fi
