#!/usr/bin/env bash

source ~/.dotfiles/installer/util.sh

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
  git config --global user.name "soriphoono" >/dev/null
  git config --global user.email "soriphoono@gmail.com" >/dev/null

  # Setup color in git user interface
  git config --global color.ui true >/dev/null

  # Setup change highlighting in git diff
  git config --global color.diff-highlight.oldNormal "red bold" >/dev/null
  git config --global color.diff-highlight.oldHighlight "red bold 52" >/dev/null
  git config --global color.diff-highlight.newNormal "green bold" >/dev/null
  git config --global color.diff-highlight.newHighlight "green bold 22" >/dev/null

  # Setup color in git diff
  git config --global color.diff.meta "11" >/dev/null
  git config --global color.diff.frag "magenta bold" >/dev/null
  git config --global color.diff.func "146 bold" >/dev/null
  git config --global color.diff.commit "yellow bold" >/dev/null
  git config --global color.diff.old "red bold" >/dev/null
  git config --global color.diff.new "green bold" >/dev/null
  git config --global color.diff.whitespace "red reverse" >/dev/null
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
  spotdl --download-ffmpeg
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
