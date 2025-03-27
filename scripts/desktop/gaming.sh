#!/usr/bin/env bash

source ./scripts/util/default.sh

# Install controller drivers

# Xbox

info "Installing XBOX controller drivers"

install_packages xpadneo-dkms

info "Installing backend tools for steam and other gaming platforms"

install_packages winetricks protontricks-git protonup gamemode gamescope

info "Installing gaming platforms"

install_packages steam lutris bottles prismlauncher gzdoom
