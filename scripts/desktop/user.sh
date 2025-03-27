#!/usr/bin/env bash

# Imports
source ./scripts/util/default.sh

install_packages stow fish starship

install_packages zip unzip unrar nvtop btop eza fastfetch git bitwarden discord thunderbird

stow .
