#!/usr/bin/env bash

source ./scripts/util/default.sh

# Install code editors

info "Installing editors"

info "Installing development tools"

install_packages git nodejs npm rustup

rustup default stable

info "Installing neovim"

install_packages neovim ripgrep lazygit

info "Installing astroNvim"

git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim

rm -rf ~/.config/nvim/.git

info "Installing vscode"

install_packages visual-studio-code-bin

# Install neovim dependencies
