#!/usr/bin/env bash

project_root=$(dirname $0)/../

source $project_root/installer/util.sh

function install_git {
  # install git
  packages=(
    "git"
  )

  # Install basic packages from the list
  inform_user "Installing git"
  sudo apt install "${packages[@]}"

  # Configure git
  inform_user "Configuring git"

  # Set git username and email
  read -p "Enter your git username: " username
  read -p "Enter your git email: " email

  git config --global user.name "$username"
  git config --global user.email "$email"

  # Install git diff viewer
  cargo install --locked \
    git-delta

  mkdir -p ~/.zsh/completions
  delta --generate-completion zsh > ~/.zsh/completions/_delta
}

function install_clang {
  packages=(
    # Clang (C/C++ development tools on LLVM)
    "clang-15"
    "clang-tools-15"
    "clang-format-15"
    "clangd-15"
  )

  # Install basic packages from the list
  inform_user "Installing Clang development tools"
  sudo apt install "${packages[@]}"
}

function install_cpp {
  packages=(
    # C/C++ development
    "build-essential"
    "gdb"
    "ninja-build"
    "cmake"
  )

  # Install basic packages from the list
  inform_user "Installing C/C++ development tools"
  sudo apt install "${packages[@]}"

  confirm_installation \
    "Do you want to install Clang development tools?" \
    install_clang
}

function install_zig {
  sudo snap install zig --classic --beta
}

function install_rust {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  rustup default stable
  source ~/.cargo/env
}

function install_java {
  packages=(
    # Java development
    "openjdk-8-jdk"
    "openjdk-11-jdk"
    "openjdk-17-jdk"
    "maven"
  )

  # Install basic packages from the list
  inform_user "Installing Java development tools"
  sudo apt install "${packages[@]}"
}

function install_python {
  packages=(
    # Python
    "python3"
    "python3-pip"
  )

  # Install basic packages from the list
  inform_user "Installing Python development tools"
  sudo apt install "${packages[@]}"
}

function install_perl {
  packages=(
    # Perl
    "perl"
  )

  # Install basic packages from the list
  inform_user "Installing Perl development tools"
  sudo apt install "${packages[@]}"
}

function install_lua {
  packages=(
    # Lua
    "lua5.4"
    "liblua5.4-dev"
    "luajit"
    "luarocks"
  )

  # Install basic packages from the list
  inform_user "Installing Lua development tools"
  sudo apt install "${packages[@]}"
}

function install_desktop_dev {
  confirm_installation \
    "Do you want to install C/C++ development tools?" \
    install_cpp
  confirm_installation \
    "Do you want to install Zig development tools?" \
    install_zig
  confirm_installation \
    "Do you want to install Rust development tools?" \
    install_rust
  confirm_installation \
    "Do you want to install Java development tools?" \
    install_java
  confirm_installation \
    "Do you want to install Python development tools?" \
    install_python
  confirm_installation \
    "Do you want to install Perl development tools?" \
    install_perl
  confirm_installation \
    "Do you want to install Lua development tools?" \
    install_lua
}

function install_QMK {
  packages=(
    # Python
    "python3"
    "python3-pip"
  )

  # Install basic packages from the list
  inform_user "Installing Python development tools"
  sudo apt install "${packages[@]}"

  # Install QMK development tools
  inform_user "Installing QMK development tools for keyboard development"
  pip install --user qmk
}

function install_keyboard_dev {
  confirm_installation \
    "Do you want to install QMK development tools?" \
    install_QMK
}

function install_node {
  packages=(
    # Node.js
    "nodejs"
    "npm"
  )

  # Install basic packages from the list
  inform_user "Installing development tools"
  sudo apt install "${packages[@]}"
}

function install_web_dev {
  confirm_installation \
    "Do you want to install Node.js development tools?" \
    install_node
}

function install_development_tools {
  confirm_installation \
    "Do you want to install desktop development tools?" \
    install_desktop_dev
  confirm_installation \
    "Do you want to install keyboard development tools?" \
    install_keyboard_dev
  confirm_installation \
    "Do you want to install web development tools?" \
    install_web_dev
}

function module {
  confirm_installation \
    "Do you want to install git?" \
    install_git
  confirm_installation \
    "Do you want to install development tools?" \
    install_development_tools
}
