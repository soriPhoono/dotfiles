#!/usr/bin/env bash

source ./scripts/util/default.sh

# Install code editors

info "Installing editors"

info "Installing neovim"

install_packages neovim ripgrep lazygit nodejs npm

info "Installing vscode"

install_packages visual-studio-code-bin

# Install neovim dependencies
