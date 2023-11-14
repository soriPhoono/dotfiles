#!/bin/bash

# Path:         ~/.dotfiles/personal/editing_tools.sh
# Description:  Bootstrap script for editing tools
# Author:       Sori Phoono <soriphoono@gmail.com>

# Editing tools for media creation

packages=()

categories=(
    "image editing"
    "video editing"
    "audio editing"
    "2d animation"
    "3d modeling/animation"
)

i=1
echo "Available categories: "
for category in "${categories[@]}"; do
    echo "    $i: $category"
    i=$((i + 1))
done
read -p "Select categories: " categories
for category in $categories; do
    case $category in
    "1")
        packages+=(
            "gimp" # Image editor built on GTK
        )
        ;;
    "2")
        packages+=(
            "shotcut" # Video editor built on Qt
        )
        ;;
    "3")
        packages+=(
            "audacity" # Audio editor
        )
        ;;
    "4")
        packages+=(
            "synfigstudio" # 2d animation software
        )
        ;;
    "5")
        packages+=(
            "blender" # 3d modeling and animation software
        )
        ;;
    esac
done

echo "Installing packages..."
paru -S --noconfirm --needed "${packages[@]}"
echo "Finished installing editing tools"

paru -c --noconfirm >/dev/null
