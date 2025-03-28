#!/usr/bin/env bash

source ./util/default.sh

# Install code editors

info "Installing editors"

info "Installing development dependencies"

install_packages git nodejs npm rustup

rustup default stable

info "Installing neovim"

install_packages neovim ripgrep lazygit

info "Installing vscode"

install_packages visual-studio-code-bin

# Install neovim dependencies
