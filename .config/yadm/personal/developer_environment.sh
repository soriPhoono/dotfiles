#!/bin/bash

# Path:         .config/yadm/personal/developer_environment.sh
# Description:  Bootstrap script for developer environment packages
# Author:       Sori Phoono <soriphoono@gmail.com>

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
commands=()

i=1
echo "Available languages:"
for language in $languages; do
    echo "    $i: $language"
    i=$((i + 1))
done
read -p "Select languages: " languages
for language in $languages; do
    case $language in
    "1")
        packages+=(
            "valgrind" # C/C++ memory leak checker
            "cmake"    # C/C++ build system
            "ninja"    # C/C++ makefile generator
            "meson"    # C/C++ build system
            "gdb"      # C/C++ debugger (gnu)
            "gcc"      # C/C++ compiler
            "lldb"     # C/C++ debugger (llvm)
            "clang"    # C/C++ compiler
            "llvm"     # C/C++ compiler infrastructure
            "lld"      # C/C++ linker optimizer
        )
        ;;
    "2")
        packages+=(
            "zls" # Zig language server
            "zig" # Zig compiler
        )
        ;;
    "3")
        packages+=(
            "rustup" # Rust toolchain manager
        )
        commands+=(
            "rustup default stable >/dev/null" # Set default rust toolchain to stable (download and configure it)
        )
        ;;
    "4")
        packages+=(
            "go"    # Go compiler
            "delve" # Go debugger
            "gopls" # Go language server
        )
        ;;
    "5")
        packages+=(
            "jdk-openjdk"   # Java compiler (version 19)
            "jdk17-openjdk" # Java compiler (version 17)
            "jdk11-openjdk" # Java compiler (version 11)
            "jdk8-openjdk"  # Java compiler (version 8)
        )
        ;;
    "6")
        packages+=(
            "perl" # Perl interpreter
        )
        ;;
    "7")
        packages+=(
            "python"     # Python interpreter
            "python-pip" # Python package manager
        )

        read -p "Install django? [Y/n] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            packages+=(
                "python-django"      # Django web framework
                "python-mysqlclient" # Python mysql connector
            )
        fi
        ;;
    "8")
        packages+=(
            "lua"      # Lua interpreter
            "luajit"   # LuaJIT compiler
            "luarocks" # Lua package manager
        )
        ;;
    "9")
        packages+=(
            "nodejs" # NodeJS interpreter
            "npm"    # NodeJS package manager
        )
        ;;
    esac
done

# Tools
# VCS
read -p "Install github-cli for integration with github remotes? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=(
        "github-cli" # Github cli
    )

    commands+=("gh auth login") # Login to github
fi

# Text Editors/Markdown writers
read -p "Install visual studio code and obsidian notation software? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=(
        "visual-studio-code-bin" # Visual studio code
        "obsidian"               # Obsidian
    )
fi

read -p "Install imhex hex viewer? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=(
        "imhex" # Hex viewer
    )
fi

# Virtual Machines
read -p "Install virtualbox and extension pack? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=(
        "virtualbox"                      # Virtualbox application
        "virtualbox-host-dkms"            # Virtualbox host kernel modules
        "virtualbox-guest-iso"            # Virtualbox guest iso
        "virtualbox-unattended-templates" # Virtualbox unattended templates
        "virtualbox-ext-oracle"           # Virtualbox extension pack
    )

    commands+=("usermod -aG vboxusers $USER") # Add user to vboxusers group
fi

# Docker
read -p "Install docker and docker-compose? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=(
        "docker"         # Docker containerized application system
        "docker-compose" # Docker compose (docker container manager)
    )

    commands+=("sudo systemctl enable docker") # Enable docker service
fi

echo "Installing packages..."
paru -S --noconfirm --needed "${packages[@]}" >/dev/null
for command in "${commands[@]}"; do
    eval $command >/dev/null
done
echo "Finished installing developer environment packages"
