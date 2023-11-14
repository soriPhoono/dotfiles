#!/bin/bash

# Path:         ~/.config/yadm/personal/office.sh
# Desc:         Install office applications
# Author:       Sori Phoono <soriphoono@gmail.com>

packages=(
    "thunderbird"
    "thunderbird-i18n-en-us"
    "hunspell"
    "hunspell-en_us"
)

echo "Installing office tools..."
paru -S --noconfirm --needed ${packages[@]}
echo "Done!"

paru -c --noconfirm >/dev/null
