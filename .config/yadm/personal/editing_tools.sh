#!/bin/bash

# Path:         ~/.dotfiles/personal/editing_tools.sh

# Editing tools for media creation

packages=()

categories=(
    "image editing"
    "video editing"
    "2d animation"
    "3d modeling"
    "3d animation"
    "3d printing"
    "audio editing"
)

i=1
echo "Available categories: "
for category in $categories; do
    echo "    $i: $category"
    i=$((i + 1))
done
read -p "Select categories: " categories
for category in $categories; do
    case $category; in
        1)
            packages+=("gimp")
            ;;
        2)
            packages+=("shotcut")
            ;;
        3)
            packages+=("synfigstudio")
            ;;
        4 | 5)
            packages+=("blender")
            ;;
        6)
            echo "3d printing is not supported yet"
            ;;
        7)
            packages+=("audacity")
            ;;
    esac
done

echo "Installing packages..."
paru -S --noconfirm --needed "${packages[@]}" >>/dev/null 2>&1
echo "Finished installing editing tools"
