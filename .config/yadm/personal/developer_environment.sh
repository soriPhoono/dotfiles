#!/bin/bash

# Path:         .config/yadm/personal/developer_environment.sh
# Description:  Bootstrap script for developer environment packages
# Author:       Sori Phoono <soriphoono@gmail.com>

# Setup development tools

MULTILIB=false
for arg in "$@"; do
    case $arg in
    "--multilib")
        MULTILIB=true
        ;;
    esac
done

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
for language in "${languages[@]}"; do
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
            "rustup default stable" # Set default rust toolchain to stable (download and configure it)
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
            "gradle"        # Java build system
            "maven"         # Java build system
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
read -p "Install github-cli for integration with github remotes? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=(
        "github-cli" # Github cli
    )

    echo "run gh auth login to setup gh-cli"
    echo "then run gh auth setup-git to setup git integration"
fi

# Text Editors/Markdown writers
read -p "Install visual studio code and obsidian notation software? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=(
        "visual-studio-code-bin" # Visual studio code
        "obsidian"               # Obsidian
    )
fi

read -p "Install imhex hex viewer? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=(
        "imhex"    # Hex viewer
        "glfw-x11" # GLFW
    )
fi

# Virtual Machines
read -p "Install qemu for virtual machines? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=(
        "edk2-ovmf"    # OVMF (Open Virtual Machine Firmware)
        "qemu-full"    # QEMU (Virtual machine manager)
        "libvirt"      # Libvirt (Virtual machine management)
        "virt-manager" # Virtual machine manager
    )

    commands+=("sudo systemctl enable libvirtd.socket")                               # Enable libvirtd service
    commands+=("sudo usermod -aG libvirt $USER")                                      # Add user to libvirt group
    commands+=("sudo cp -r ~/.config/yadm/personal/conf/etc/libvirt/* /etc/libvirt/") # Copy libvirt configs
fi

# QMK
read -p "Install qmk firmware development tools? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    paru -U --noconfirm --needed https://archive.archlinux.org/packages/a/avr-gcc/avr-gcc-8.3.0-1-x86_64.pkg.tar.xz
    if grep -q "IgnorePkg" /etc/pacman.conf; then
        sudo sed -i "s/IgnorePkg = /IgnorePkg = avr-gcc /" /etc/pacman.conf
    else
        sudo sed -i "s/#IgnorePkg = /IgnorePkg = avr-gcc /" /etc/pacman.conf
    fi

    packages+=(
        "qmk" # QMK firmware development tools
    )
fi

# Android development tools
if $MULTILIB && read -p "Install android studio? [y/N] " -n 1 -r; then
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        packages+=(
            "android-studio"                   # Android studio
            "android-sdk-cmdline-tools-latest" # Android sdk command line tools
            "android-sdk-build-tools"          # Android sdk build tools
            "android-sdk-platform-tools"       # Android sdk platform tools
            "android-platform"                 # Android platform
            "android-emulator"                 # Android emulator
            "android-support-repository"       # Android support repository
            "aosp-devel"                       # Android open source project development tools
            "lineageos-devel"                  # LineageOS development tools
            "repo"                             # Android repository tool
            "android-udev"                     # Android udev rules
            "heimdall"                         # Heimdall flash tool for Samsung devices
        )

        # TODO: set ANDROID_HOME environment variable

        commands+=("sudo groupadd android-sdk")                             # Add android-sdk group
        commands+=("sudo usermod -aG android-sdk $USER")                    # Add user to android-sdk group
        commands+=("sudo setfacl -R -m g:android-sdk:rwx /opt/android-sdk") # Set android-sdk group permissions
        commands+=("sudo setfacl -d -m g:android-sdk:rwX /opt/android-sdk") # Set android-sdk group default permissions
    fi
fi

# Docker
read -p "Install docker and docker-compose? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=(
        "docker"         # Docker containerized application system
        "docker-compose" # Docker compose (docker container manager)
    )

    commands+=("sudo systemctl enable docker") # Enable docker service
fi

echo "Installing packages..."
paru -S --noconfirm --needed "${packages[@]}"
for command in "${commands[@]}"; do
    eval "$command" >/dev/null
done
echo "Finished installing developer environment packages"

paru -c --noconfirm >/dev/null
