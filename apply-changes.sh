#!/usr/bin/env bash

function confirm_exit() {
  read -n 1 -rp "Do you want to exit? [y/n] "
  echo
  if [[ $REPLY == "y" ]]; then
    exit 1
  fi
}

trap confirm_exit SIGINT

# Get the system configuration name from the flake
nix flake show | grep "NixOS configuration" | awk '{print $2}'
read -rp "Enter the system configuration name: " system

# Check if any files in the flake have been modified
if [[ $(git status --porcelain) ]]; then
  echo "[WARN]: There are uncommitted changes in the flake"

  read -n 1 -rp "Do you want to commit the changes? [y/n] "
  echo
  if [[ $REPLY == "y" ]]; then
    git add -A
    read -rp "Enter the commit message: "
    git commit -m "$REPLY"
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
  if [[ ! $(sudo nixos-rebuild boot --flake ".#$system") ]]; then
    echo "[ERROR]: Changes could not be applied."

    exit 1
  fi

  # Wait till next reboot
  echo "Changes will be applied on the next reboot."
fi

echo "[INFO]: Cleaning up..."
sudo nix-collect-garbage --delete-old

echo "[INFO]: Done."
echo "[INFO]: Exiting..."

# Exit successfully
exit 0
