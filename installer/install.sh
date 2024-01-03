#!/usr/bin/env bash

# Install script for this dotfiles repo

export ROOT_DIR="$(dirname $0)"
export PACKAGE_MANAGER="sudo pacman --noconfirm --needed"

source "$ROOT_DIR/core/util.sh"

source "$ROOT_DIR/core/repos.sh"
source "$ROOT_DIR/core/drivers.sh"

check_root # Ensure script is not running as root (sudo is used when needed)

function configure_pacman() {
    backup /etc/pacman.conf # Copy pacman config, enables color and parallel downloads
    sudo sed -i 's/#Color/Color/g' /etc/pacman.conf
    sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/g' /etc/pacman.conf
    if [[ $(configure_repos) == 1 ]]; then # Configure pacman repositories
        export MULTILIB_ENABLED=true
    fi

    install_packages paru reflector rsync              # Install paru (AUR Helper), reflector (Mirrorlist updater) and rsync (File transfer utility)
    export PACKAGE_MANAGER="paru --noconfirm --needed" # Set paru as package manager

    backup /etc/paru.conf
    sudo sed -i 's/#BottomUp/BottomUp/g' /etc/paru.conf

    backup /etc/xdg/reflector/reflector.conf 1
    sudo sh -c "echo -e '--save /etc/pacman.d/mirrorlist\n--sort rate\n--protocol https\n--latest 15' >> /etc/xdg/reflector/reflector.conf"
    sudo systemctl start reflector.service
    sudo systemctl enable --now reflector.timer
}

function configure_cli() {
    install_packages linux-headers \
        base-devel \
        xdg-user-dirs \
        pacman-contrib \
        nano \
        neovim \
        fish \
        fisher \
        starship \
        neofetch \
        curl \
        wget \
        less \
        eza \
        bat \
        diff-so-fancy \
        dua-cli \
        duf \
        tre-command \
        scc \
        btop

    mkdir -p ~/D{ownloads,ocuments,esktop} ~/Music ~/Videos ~/P{ictures,ublic} ~/Templates
    xdg-user-dirs-update

    chsh -s /usr/bin/fish $(whoami)

    sudo systemctl enable paccache.timer

    bat cache --build

    # Setup git
    read -rp "What is your git username? " username
    read -rp "What is your git email? " email

    # Set git username and email
    git config --global user.name "$username"
    git config --global user.email "$email"

    # Set git editor
    git config --global core.editor "nvim"

    # Set git diff tool enhancements
    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
    git config --global interactive.diffFilter "diff-so-fancy --patch"

    # Setup color in git user interface
    git config --global color.ui true

    # Setup change highlighting in git diff
    git config --global color.diff-highlight.oldNormal "red bold"
    git config --global color.diff-highlight.oldHighlight "red bold 52"
    git config --global color.diff-highlight.newNormal "green bold"
    git config --global color.diff-highlight.newHighlight "green bold 22"

    # Setup color in git diff
    git config --global color.diff.meta "11"
    git config --global color.diff.frag "magenta bold"
    git config --global color.diff.func "146 bold"
    git config --global color.diff.commit "yellow bold"
    git config --global color.diff.old "red bold"
    git config --global color.diff.new "green bold"
    git config --global color.diff.whitespace "red reverse"

    echo "Configured git for workflow publishing"

    install_packages networkmanager \
        networkmanager-openvpn \
        networkmanager-openconnect \
        ufw

    # Enable network manager on boot
    sudo systemctl enable NetworkManager.service

    # Enable firewall
    sudo systemctl enable ufw.service
    sudo ufw default deny
    sudo ufw enable
}

function install_desktop() {
    install_packages blueberry \
        brightnessctl \
        foot \
        fuzzel \
        gjs \
        gnome-bluetooth-3.0 \
        gnome-control-center \
        gnome-keyring \
        gobject-introspection \
        grim \
        gtk3 \
        gtk-layer-shell \
        libdbusmenu-gtk3 \
        catppuccin-gtk-theme-mocha \
        papirus-icon-theme \
        meson \
        npm \
        plasma-browser-integration \
        playerctl \
        polkit-gnome \
        ripgrep \
        sassc \
        slurp \
        swayidle \
        typescript \
        upower \
        xorg-xrandr \
        webp-pixbuf-loader \
        wireplumber \
        wl-clipboard \
        tesseract \
        yad \
        ydotool \
        adw-gtk3-git \
        gojq \
        gradience-git \
        gtklock \
        gtklock-playerctl-module \
        gtklock-powerbar-module \
        gtklock-userinfo-module \
        hyprland-git \
        lexend-fonts-git \
        python-material-color-utilities \
        python-pywal \
        python-poetry \
        python-build \
        python-pillow \
        swaylock-effects-git \
        swww \
        ttf-material-symbols-variable-git \
        ttf-space-mono-nerd \
        ttf-jetbrains-mono-nerd \
        wayland-idle-inhibitor-git \
        wlogout \
        wlsunset-git \
        hyprpicker-git \
        sddm \
        sddm-sugar-candy-git \
        gvfs \
        gvfs-mtp \
        xorg-xlsclients \
        xwaylandvideobridge-bin \
        xdg-desktop-portal \
        xdg-desktop-portal-hyprland \
        qt5-wayland \
        qt5ct \
        qt6-wayland \
        qt6ct \
        file-roller \
        gnome-disk-utility \
        imv \
        mpv \
        pipewire \
        pipewire-audio \
        pipewire-alsa \
        pipewire-jack \
        pipewire-pulse \
        easyeffects \
        gstreamer \
        gst-plugins-base \
        gst-plugins-good \
        gst-plugins-pipewire \
        bluez \
        bluez-utils \
        firefox

    sudo usermod -aG video "$(whoami)"
    sudo usermod -aG input "$(whoami)"
    sudo usermod -aG disk "$(whoami)"
    sudo usermod -aG audio "$(whoami)"
    sudo usermod -aG games "$(whoami)"

    sudo systemctl enable bluetooth.service
    systemctl --user enable pipewire.service
    sudo systemctl enable sddm.service
}

configure_pacman

git submodule update --init --recursive -- "$(dirname $ROOT_DIR)"

install_drivers
configure_cli
install_desktop

paru -c
