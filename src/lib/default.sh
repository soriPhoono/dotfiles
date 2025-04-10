#!/usr/bin/env bash

source ./src/util/default.sh

logger_init

sh ./src/lib/chaotic-aur.sh

info "Deploying configurations"

sudo cp -r ./root/* /

info "Installing paru and configuring pacman"

install_packages paru pacman-contrib reflectors \
  easyeffects calf lsp-plugins-lv2 zam-plugins-lv2

sudo systemctl enable --now paccache.timer
sudo systemctl enable --now reflector.timer

sh ./src/lib/security.sh
sh ./src/lib/plymouth.sh

sudo systemctl enable --now bluetooth.service
