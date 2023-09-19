#!/bin/bash

# Path:         ~/.config/yadm/personal/gaming.sh

MULTILIB=false
for arg in "$@"; do
    case $arg in
    -m | --multilib)
        MULTILIB=true
        ;;
    esac
done

# Install core packages for gaming environment
packages=(
    "soundfont-fluid"
    "boxtron"
    "protonup-git"
    "protontricks-git"
    "wine"
    "winetricks"
    "gamemode"
    "mangohud"
    "replay-sorcery"
    "dxvk-async-git"
    "vkd3d"
    "gamescope"
)

# Install proton and it's dependencies
if $MULTILIB; then
    packages+=("lib32-gamemode" "lib32-vkd3d")
fi

# Install steam(-native) and it's dependencies
read -p "Install steam-native-runtime? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=("steam" "steam-native-runtime")
fi

read -p "Install heroic-launcher? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=("heroic-games-launcher-bin")
fi

read -p "Install minecraft launcher? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=("prismlauncher")
fi

read -p "Install tales of maj'eyal? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=("tome4-bin" "tome4-zomnibus_addon")
fi

echo "Installing packages..."
paru -S --noconfirm --needed "${packages[@]}" >>/dev/null 2>&1
echo "Installed games packages."
