#!/usr/bin/env bash

# Imports
source ./util/default.sh

install_packages stow

stow .

install_packages fish starship

chsh --shell /usr/bin/fish

install_packages zip unzip unrar nvtop btop eza fastfetch git bc tmux yazi

install_packages bitwarden firefox discord thunderbird obsidian
