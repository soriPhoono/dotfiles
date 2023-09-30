#!/bin/bash

# Path:         ~/.config/yadm/personal/office.sh
# Desc:         Install office applications
# Author:       Sori Phoono <soriphoono@gmail.com>

packages=(
    "libreoffice-fresh"                  # LibreOffice Fresh
    "libreoffice-extension-texmaths"     # LibreOffice extension for equations
    "libreoffice-extension-writer2latex" # LibreOffice extension for LaTeX
    "libreoffice-extension-languagetool" # LibreOffice extension for grammar
    "hunspell"                           # Spell checker
    "hunspell-en_us"                     # Spell checker for US English
    "hyphen"                             # Hyphenation patterns
    "hyphen-en"                          # Hyphenation patterns for US English
    "libmythes"                          # Thesaurus
    "mythes-en"                          # Thesaurus for US English

    "cups"                        # Printer support
    "libpaper"                    # Library for handling paper characteristics
    "cups-pk-helper"              # PolicyKit helper to configure cups
    "cups-pdf"                    # PDF printer
    "ghostscript"                 # PostScript interpreter
    "gsfonts"                     # PostScript fonts
    "foomatic-db"                 # Foomatic printer database
    "foomatic-db-ppds"            # Foomatic printer database engine
    "foomatic-db-nonfree"         # Foomatic printer database (nonfree)
    "foomatic-db-nonfree-ppds"    # Foomatic printer database engine (nonfree)
    "gutenprint"                  # Printer drivers
    "foomatic-db-gutenprint-ppds" # Foomatic printer database for Gutenprint
    "system-config-printer"       # Printer configuration
)

echo "Installing office tools..."
paru -S --noconfirm --needed ${packages[@]}
echo "Done!"

echo "Enabling cups service..."
sudo systemctl enable cups.socket

paru -c --noconfirm >/dev/null
