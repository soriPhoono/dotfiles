#!/usr/bin/env bash

source scripts/util.sh

# Get the system configuration name from the flake
nix flake show | grep "NixOS configuration" | awk '{print $2}'
read -rp "[INFO] Enter the system configuration name: " system

# Check if any files in the flake have been modified
if [[ $(git status --porcelain) ]]; then
  echo "[WARN]: There are uncommitted changes in the flake"

  read -n 1 -rp "[INFO] Do you want to commit the changes? [y/n] "
  echo
  if [[ $REPLY == "y" ]]; then
    git add -A
    read -rp "[INFO] Enter the commit message: "
    git commit -m "$REPLY"
  fi
fi

read -rp "[INFO] Do you want to apply the changes, or wait till the next reboot? [apply/wait] "
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
  if [[ ! $(sudo nixos-rebuild boot --flake ".#$system") ]]; then
    echo "[ERROR]: Changes could not be applied."

    exit 1
  fi

  # Wait till next reboot
  echo "[INFO] Changes will be applied on the next reboot."
fi

echo "[INFO]: Cleaning up..."
sudo nix-collect-garbage --delete-old

echo "[INFO]: Done."
echo "[INFO]: Exiting..."

# Exit successfully
exit 0
