#!/usr/bin/env bash

project_root=$(dirname $0)/../

source $project_root/installer/util.sh

function install_shell {
  packages=(
    # Terminal tools
    "zsh"
    "neofetch"
  )

  # Install basic packages from the list
  inform_user "Installing terminal tools"
  sudo apt install "${packages[@]}"

  # Install starship
  inform_user "Installing starship"
  cargo install starship --locked

  # Set zsh as the default shell
  inform_user "Setting zsh as the default shell"
  chsh -s $(which zsh)
}

function install_cli {
  packages=(
    "btop"
    "jq"

    "yt-dlp"
  )

  # Install basic packages from the list
  inform_user "Installing CLI tools"
  sudo apt install "${packages[@]}"

  # Install cli tools via programming package managers
  inform_user "Installing CLI tools"

  cargo install --locked \
    cargo-update \
    eza dua-cli \
    tre-command \
    bat

  mkdir -p ~/.config/bat/themes
  ln ~/.local/share/bat/themes/*.tmTheme ~/.config/bat/themes/
  bat cache --build

  pip install --user spotdl
  zsh -c "spotdl --download-ffmpeg"
}

# Module entry point
function module {
  confirm_installation \
    "Do you want to install the ZSH shell?" \
    install_shell
  confirm_installation \
    "Do you want to install the CLI tools for the provided configurations?" \
    install_cli
}
