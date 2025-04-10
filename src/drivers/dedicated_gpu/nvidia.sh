#!/usr/bin/env bash

# Imports
source ./src/util/default.sh

# Copy config files

sudo cp -r ./src/drivers/root/* /

# Install drivers

info "Installing Nvidia open kernel drivers"

install_packages linux-zen-headers dkms nvidia-open-dkms nvidia-utils lib32-nvidia-utils nvidia-prime

# Install opencl https://wiki.archlinux.org/title/GPGPU

info "Installing Nvidia opencl binarys"

install_packages opencl-nvidia lib32-opencl-nvidia ocl-icd lib32-ocl-icd clinfo

# Install CUDA

info "Installing cuda drivers"

install_packages cuda
