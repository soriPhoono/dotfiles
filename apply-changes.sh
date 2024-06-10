#!/usr/bin/env bash

# TODO: fix the script not recognizing the value of the system variable, I'm kinda dumb lol

# This script is used to apply changes to the system

# Get the system configuration name from the flake

# Check if any files in the flake have been modified
if [[ $(git status --porcelain) ]]; then
  echo "[WARN]: There are uncommitted changes in the flake"

  git add -A
fi

read -rp "Do you want to apply the changes, or wait till the next reboot? [apply/wait] "
if [[ $REPLY == "apply" ]]; then
  # Apply changes
  echo "[INFO]: Applying changes..."

  # Update the system
  if [[ $(sudo nixos-rebuild switch --flake '.#$system') && $(hyprctl reload) ]]; then
    echo "[ERROR]: Changes could not be applied."

    exit 1
  fi

  echo "[INFO]: Changes applied successfully."
else
  echo "[INFO]: Building system configuration..."

  # Update the system
  if [[ $(sudo nixos-rebuild build --flake .#$system) ]]; then
    echo "[ERROR]: Changes could not be applied."

    exit 1
  fi

  # Wait till next reboot
  echo "Changes will be applied on the next reboot."
fi
