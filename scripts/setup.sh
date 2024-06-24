#!/usr/bin/env bash

source scripts/util.sh

# Get the system configuration name from the flake
nix flake show | grep "NixOS configuration" | awk '{print $2}'
system = $(input "Enter the system configuration name: ")

# Enable flakes
sudo sed -i 's/^}$/  nix.settings.experimental-features = [ "nix-command" "flakes" ];\n}/' /etc/nixos/configuration.nix
sudo nixos-rebuild switch

# Assume the new disk is mounted at /mnt
sudo nixos-generate-config --root /mnt
sudo cp /mnt/etc/nixos/hardware-configuration.nix nixos/hosts/"$system"/hardware-configuration.nix

sudo nixos-install --root /mnt --flake ".#$system" # TODO: enable this flag when sops-nix is done --no-root-passwd

reboot
