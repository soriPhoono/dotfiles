#!/usr/bin/env bash

function install-git {
  packages=(
    "git"
  )

  sudo apt install "${packages[@]}"

  # Configure git
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
  sudo apt install "${packages[@]}"

  # Install Zig

  # Install Rust
  curl https://sh.rustup.rs -sSf | sh

  rustup default stable

  # Install QMK development tools
  pip install --user qmk
}

# Module entry point
function module-cli {
  install-git
  install-dev

  packages=(
    "zsh"
    "neofetch"
  )

  # Install starship
  cargo install starship --locked

  # Set zsh as the default shell
  echo "Setting zsh as the default shell"
  chsh -s $(which zsh)
}
