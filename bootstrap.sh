#!/usr/bin/env bash

echo "Dotfiles -- Sori Phoono"

cd ~/.dotfiles || exit

git submodule init && git submodule update

paru -S --needed --noconfirm stow

stow .

paru -S --needed --noconfirm fish starship btop \
  eza fastfetch zip unzip unrar nvtop bc yazi \
  nodejs npm rustup ripgrep zellij bitwarden \
  firefox profile-sync-daemon discord obsidian

chsh --shell /usr/bin/fish

rustup default stable

systemctl --user enable --now psd.service
