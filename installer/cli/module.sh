#!/usr/bin/env bash

project_root=$(dirname $0)/../../

source $project_root/installer/util.sh

function install-git {
  # install git
  packages=(
    "git"
  )

  inform_user "Installing git"
  sudo apt install "${packages[@]}"

  # Configure git
  inform_user "Configuring git"

  # Set git username and email
  read -p "Enter your git username: " username
  read -p "Enter your git email: " email

  git config --global user.name "$username"
  git config --global user.email "$email"
}

function install-dev {
  packages=(
    # C/C++ development
    "build-essential"
    "gdb"
    "ninja-build"
    "cmake"
    "clang-15"
    "clang-tools-15"
    "clang-format-15"
    "clangd-15"

    # Java development
    "openjdk-8-jdk"
    "openjdk-11-jdk"
    "openjdk-17-jdk"
    "maven"

    # Python
    "python3"
    "python3-pip"

    # Perl
    "perl"

    # Lua
    "lua5.4"
    "liblua5.4-dev"
    "luajit"
    "luarocks"

    # Node.js
    "nodejs"
    "npm"
  )

  # Install basic packages from the list
  inform_user "Installing development tools"
  sudo apt install "${packages[@]}"

  # Installing extra development tools
  inform_user "Installing special development tools"

  # Install Zig
  inform_user "Installing Zig"
  sudo snap install zig --classic --beta

  # Install Rust
  inform_user "Installing Rust"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  rustup default stable
  source ~/.cargo/env

  # Install QMK development tools
  inform_user "Installing QMK development tools for keyboard development"
  pip install --user qmk
}

# Install user packages
function install-user {
  packages=(
    # Media downloaders
    "yt-dlp"
  )

  # Install basic packages from the list
  inform_user "Installing user packages, such as media downloaders"
  sudo apt install "${packages[@]}"

  # Install spotdl
  inform_user "Installing spotdl"
  pip install --user spotdl
  zsh -c "spotdl --download-ffmpeg"
}

# Module entry point
function module-cli {
  install-git
  install-dev
  install-user

  packages=(
    # Terminal tools
    "zsh"
    "neofetch"

    # Terminal environment
    "duf"
    "btop"
    "jq"
  )

  # Install basic packages from the list
  inform_user "Installing terminal tools"
  sudo apt install "${packages[@]}"

  # Install starship
  inform_user "Installing starship and other tools for a better experience in the terminal"
  cargo install starship bat --locked

  # Install advanced tool replacements
  cargo install cargo-update \
                eza dua-cli \
                tre-command \
                git-delta

  # Set zsh as the default shell
  inform_user "Setting zsh as the default shell"
  chsh -s $(which zsh)
}
