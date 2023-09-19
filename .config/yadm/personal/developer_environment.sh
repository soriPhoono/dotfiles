#!/bin/bash

# Path: .config/yadm/personal/developer_environment.sh

# Setup development tools

languages=(
    "C/C++"
    "Zig"
    "Rust"
    "Go"
    "Java"
    "Perl"
    "Python"
    "Lua"
    "HTML/CSS/JS"
)

packages=()

i=1
echo "Available languages:"
for language in $languages; do
    echo "    $i: $language"
    i=$((i + 1))
done
read -p "Select languages: " languages
for language in $languages; do
    case $language in
    1)
        packages+=("valgrind" "cmake" "ninja" "meson" "gdb" "gcc" "lldb" "clang" "llvm" "lld")
        ;;
    2)
        packages+=("zls" "zig")
        ;;
    3)
        packages+=("rust")
        ;;
    4)
        packages+=("go" "delve" "gopls")
        ;;
    5)
        packages+=("jdk-openjdk" "jdk17-openjdk" "jdk11-openjdk" "jdk8-openjdk")
        ;;
    6)
        packages+=("perl")
        ;;
    7)
        packages+=("python" "python-pip")

        read -p "Install django? [Y/n] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            packages+=("python-django" "python-mysqlclient")
        fi
        ;;
    8)
        packages+=("luarocks" "luajit" "lua")
        ;;
    9)
        packages+=("nodejs" "npm")
        ;;
    esac
done

# Tools
# VCS
read -p "Install github-cli for integration with github remotes? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=("github-cli")
fi
if ! gh auth status; then
    gh auth login
fi

# Text Editors/Markdown writers
read -p "Install visual studio code and obsidian notation software? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=("visual-studio-code-bin" "obsidian")
fi

read -p "Install imhex hex viewer? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=("imhex")
fi

# Virtual Machines
read -p "Install virtualbox and extension pack? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=("virtualbox" "virtualbox-host-dkms" "virtualbox-guest-iso" "virtualbox-unattended-templates" "virtualbox-ext-oracle")
fi

sudo usermod -aG vboxusers "$USER"

# Docker
read -p "Install docker and docker-compose? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=("docker" "docker-compose")
fi

sudo systemctl enable --now docker.service

echo "Installing packages..."
paru -S --noconfirm --needed "${packages[@]}"
echo "Finished installing developer environment packages"
