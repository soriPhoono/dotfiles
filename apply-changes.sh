#!/usr/bin/env bash

# This script is used to apply changes to the system

function confirm_exit() {
  read -rp "Do you want to exit? [y/n] "
  if [[ $REPLY == "y" ]]; then
    exit 1
  fi
}

trap confirm_exit SIGINT

# Backup wallpaper collection
if [[ -d ~/Pictures/wallpapers ]]; then
  cp assets/wallpapers/* ~/Pictures/wallpapers/
fi

# Get the system configuration name from the flake
nix flake show | grep "NixOS configuration" | awk '{print $2}'
read -rp "Enter the system configuration name: " system

# Check if any files in the flake have been modified
if [[ $(git status --porcelain) ]]; then
  echo "[WARN]: There are uncommitted changes in the flake"

  read -rp "Do you want to commit the changes? [y/n] "
  if [[ $REPLY == "y" ]]; then
    git add -A
    read -rp "Enter the commit message: "
    git commit -m $REPLY
  fi
fi

read -rp "Do you want to apply the changes, or wait till the next reboot? [apply/wait] "
if [[ $REPLY == "apply" ]]; then
  # Apply changes
  echo "[INFO]: Applying changes..."

  # Update the system
  if [[ ! $(sudo nixos-rebuild switch --flake ".#$system") && $(hyprctl reload) ]]; then
    echo "[ERROR]: Changes could not be applied."

    exit 1
  fi

  echo "[INFO]: Changes applied successfully."
else
  echo "[INFO]: Building system configuration..."

  # Update the system
  if [[ ! $(sudo nixos-rebuild build --flake ".#$system") ]]; then
    echo "[ERROR]: Changes could not be applied."

    exit 1
  fi

  # Wait till next reboot
  echo "Changes will be applied on the next reboot."
fi

# Exit successfully
exit 0
