#!/usr/bin/env bash

# Imports
source ./scripts/util/default.sh

function invoke-nix() {
  binary=$1

  command "$binary" --extra-experimental-features "nix-command flakes" "${@:2}"
}

# Install chaotic AUR

sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB

sudo pacman -U --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

if ! grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
  echo -e "[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
fi

# Install module dependencies

sudo pacman -Syu --needed paru nix

invoke-nix nix run home-manager/master -- init --switch
