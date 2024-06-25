#!/usr/bin/env bash

source scripts/util.sh

# Get the system configuration name from the flake
nix flake show | grep "NixOS configuration" | awk '{print $2}'
system=$(input "Enter the system configuration name")

# Check if any files in the flake have been modified
if [[ $(git status --porcelain) ]]; then
  warn "Uncommitted changes will not be applied"

  commit=$(input "Do you want to commit the changes?")
  echo
  if [[ $commit == "y" ]]; then
    git add -A
    message=$(input "Enter the commit message")
    git commit -m "$message"
  fi
fi

operation=$(input "Do you want to apply the changes, or wait till the next reboot? [apply/wait]")
if [[ $REPLY == "apply" ]]; then
  # Apply changes
  info "Applying changes..."

  # Update the system
  if [[ ! $(sudo nixos-rebuild switch --flake ".#$system") && $(hyprctl reload) ]]; then
    error "Changes could not be applied."

    exit 1
  fi

  info "Changes applied successfully."
else
  info "Building system configuration..."

  # Update the system
  if [[ ! $(sudo nixos-rebuild boot --flake ".#$system") ]]; then
    error "Changes could not be applied."

    exit 1
  fi

  # Wait till next reboot
  info "Changes will be applied on the next reboot."
fi

info "Cleaning up..."
sudo nix-collect-garbage --delete-old

info "Done."
info "Exiting..."

# Exit successfully
exit 0
