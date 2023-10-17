#!/bin/bash

# Path:        ~/.dotfiles/personal/recording_tools.sh
# Description: Bootstrap script for recording tools
# Author:      Sori Phoono <soriphoono@gmail.com>

MULTILIB=false
for arg in "$@"; do
	case $arg in
	-m | --multilib)
		MULTILIB=true
		;;
	esac
done

packages=(
	"obs-gstreamer"         # OBS Studio gstreamer plugin for gstreamer based hardware accellerated encoding/decoding (AUR)
	"obs-vkcapture-git"     # OBS Studio Vulkan capture plugin (AUR)
	"obs-backgroundremoval" # OBS Studio background removal plugin (AUR)
)

if grep -q "dgpu_vendor" ~/.config/yadm/drivers/vendors | (grep -q "AMD" && grep -q "amf-amdgpu-pro" <<<"$(paru -Q)"); then
	packages+=("obs-studio-amf") # OBS Studio AMD media framework plugin (AUR)
else
	packages+=("obs-studio-git") # OBS Studio (AUR)
fi

if "$MULTILIB"; then
	packages+=("lib32-obs-vkcapture-git") # OBS Studio Vulkan capture plugin (32-bit) (AUR)
fi

echo "Installing packages..."
paru -S --noconfirm --needed "${packages[@]}"
echo "Finished installing recording tools"

paru -c --noconfirm >/dev/null
