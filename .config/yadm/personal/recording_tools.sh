#!/bin/bash

# Path:        ~/.dotfiles/personal/recording_tools.sh

MULTILIB=false
for arg in "$@"; do
    case $arg in
    -m | --multilib)
        MULTILIB=true
        ;;
    esac
done

packages=("obs-gstreamer" "obs-vkcapture-git" "obs-backgroundremoval")

if grep -q "AMD" <<<"$(lspci | grep -e \"VGA\" -e \"3D\")" && grep -q "amf-amdgpu-pro" <<<"$(paru -Q)"; then
    packages+=("obs-studio-amf")
else
    packages+=("obs-studio-git")
fi

if $MULTILIB; then
    packages+=("lib32-obs-vkcapture-git")
fi

echo "Installing packages..."
paru -S --noconfirm --needed "${packages[@]}" >>/dev/null 2>&1
echo "Finished installing recording tools"
