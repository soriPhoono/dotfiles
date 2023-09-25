#!/bin/bash

# Path:         ~/.config/yadm/personal/office.sh
# Desc:         Install office applications
# Author:       Sori Phoono <soriphoono@gmail.com>

packages=(
    "libreoffice-fresh"
    "libreoffice-extension-texmaths"
    "libreoffice-extension-writer2latex"
    "libreoffice-extension-languagetool"
    "hunspell"
    "hunspell-en_us"
    "hyphen"
    "hyphen-en"
    "libmythes"
    "mythes-en"
)

echo "Installing libreoffice..."
paru -S --noconfirm --needed ${packages[@]} >/dev/null
echo "Done!"
