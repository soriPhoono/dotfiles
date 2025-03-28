#!/usr/bin/env bash

source ./util/default.sh

# Install controller drivers

# Xbox

info "Installing XBOX controller drivers"

install_packages linux-zen-headers xpadneo-dkms

# Install gaming backend

info "Installing backend tools for steam and other gaming platforms"

install_packages winetricks protontricks-git protonup gamemode gamescope

# Install gaming platforms

info "Installing gaming platforms"

install_packages steam lutris bottles prismlauncher gzdoom
