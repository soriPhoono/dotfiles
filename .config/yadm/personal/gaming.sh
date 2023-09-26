#!/bin/bash

# Path:         ~/.config/yadm/personal/gaming.sh
# Description:  Bootstrap script for gaming environment
# Author:       Sori Phoono (soriphoono@gmail.com)

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
    "soundfont-fluid"  # FluidR3 soundfont
    "boxtron"          # DOSBox fork for Steam Play compatibility
    "protonup-git"     # Proton updater
    "protontricks-git" # Proton tricks (configuration tool)
    "wine"             # Wine
    "winetricks"       # Wine tricks (configuration tool)
    "gamemode"         # Game mode
    "mangohud"         # MangoHud (game overlay)
    "replay-sorcery"   # Replay sorcery (game replay tool)
    "dxvk-async-git"   # DXVK async (DirectX to Vulkan translation layer)
    "vkd3d"            # VKD3D (DirectX 12 to Vulkan translation layer)
    "gamescope"        # Gamescope (game compositor) (for fixing issues in window manager on wayland based compositors)
)

# Install proton and it's dependencies
if $MULTILIB; then
    packages+=(
        "lib32-gamemode" # Game mode (32-bit)
        "lib32-vkd3d"    # VKD3D (32-bit)
    )
fi

# Install steam(-native) and it's dependencies
read -p "Install steam? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if $MULTILIB; then
        packages+=(
            "steam" # Steam
        )
    else
        echo "Steam requires multilib to be enabled."
    fi
fi

read -p "Install heroic-launcher? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=(
        "heroic-games-launcher-bin" # Heroic games launcher
    )
fi

read -p "Install minecraft launcher? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=(
        "prismlauncher" # Minecraft instance and version manager
    )
fi

read -p "Install tales of maj'eyal? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=(
        "tome4-bin"            # Tales of Maj'Eyal
        "tome4-zomnibus_addon" # Tales of Maj'Eyal Zomnibus addon (optional qol mods to improve experience while preserving vanilla feel)
    )
fi

echo "Installing packages..."
paru -S --noconfirm --needed "${packages[@]}" >/dev/null
echo "Installed games packages."

paru -c --noconfirm >/dev/null
