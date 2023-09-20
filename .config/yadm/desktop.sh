#!/bin/bash

# Path:         ~/.config/yadm/desktop/bootstrap

packages=(
    "sddm"
    "sddm-sugar-candy-git"
    "xorg-xhost"
    "xxd-standalone"
    "xorg-xauth"
    "xorg-xinit"
    "xorg-xmodmap"
    "xdg-desktop-portal"
    "qtile"
    "polybar"
    "picom-ftlabs-git"
    "xidlehook"
    "qt5-graphicaleffects"
    "qt5-quickcontrols2"
    "qt5-svg"
    "rofi"
    "betterlockscreen"
    "cool-retro-term"
    "cmatrix"
    "redshift"
    "unclutter"
    "catppuccin-gtk-theme-mocha"
    "catppuccin-cursors-mocha"
    "papirus-icon-theme"
    "playerctl"
    "zenity"
    "imagemagick"
    "cava"
    "qt5ct"
    "qt6ct"
    "nwg-look"
    "font-manager"
    "adobe-source-code-pro-fonts"
    "ttf-sourcecodepro-nerd"
    "ttf-nerd-fonts-symbols"
    "ttf-nerd-fonts-symbols-mono"
    "noto-fonts-emoji"
    "polkit-gnome"
    "gnome-keyring"
    "alacritty"
    "gvfs"
    "gvfs-afc"
    "gvfs-mtp"
    "gvfs-gphoto2"
    "pcmanfm-gtk3"
    "file-roller"
    "gnome-disk-utility"
    "gparted"
    "bleachbit"
    "flameshot"
    "imv"
    "exaile"
    "mpv"
    "vlc"
    "qbittorrent"
)

commands=()

echo "Installing pipewire audio server..."
packages+=("pipewire" "pipewire-audio" "pipewire-alsa" "pipewire-jack" "pipewire-pulse" "wireplumber" "pavucontrol" "carla" "easyeffects")
echo "Installed pipewire audio server!"

echo "Installing gstreamer video pipeline..."
packages+=("gstreamer" "gst-libav" "gst-plugins-base" "gst-plugins-good" "gst-plugin-pipewire" "gstreamer-vaapi")
for line in "$(lspci | grep -e \"3D\" -e \"VGA\")"; do
    case "$line" in
    "*NVIDIA*")
        packages+=("gst-plugins-bad")
        commands+=("sudo tee -a /etc/environment >/dev/null 2>&1 <<EOF
GST_PLUGIN_FEATURE_RANK=nvmpegvideodec:MAX,nvmpeg2videodec:MAX,nvmpeg4videodec:MAX,nvh264sldec:MAX,nvh264dec:MAX,nvjpegdec:MAX,nvh265sldec:MAX,nvh265dec:MAX,nvvp9dec:MAX
EOF")
        ;;
    esac
done
echo "Installed gstreamer video pipeline!"

echo "Installing packages..."
paru -S --noconfirm --needed "${packages[@]}" >>/dev/null 2>&1
for command in $commands; do
    eval "$command"
done
echo "Finished installing core desktop environment packages"

read -p "Enable bluetooth? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing bluetooth packages..."
    paru -S --noconfirm --needed bluez bluez-utils blueberry >>/dev/null 2>&1
    sudo systemctl enable bluetooth >>/dev/null 2>&1
    echo "Finished installing bluetooth packages"
fi

sudo tee -a /etc/environment >/dev/null 2>&1 <<EOF
TERM=alacritty
QT_QPA_PLATFORMTHEME=qt5ct
EOF

sudo tee -a /etc/sudo.conf >/dev/null 2>&1 <<EOF
Path askpass /usr/local/bin/zenity-passphrase
EOF

sudo usermod -aG video "$(whoami)" >>/dev/null 2>&1
sudo usermod -aG input "$(whoami)" >>/dev/null 2>&1
sudo usermod -aG disk "$(whoami)" >>/dev/null 2>&1
sudo usermod -aG audio "$(whoami)" >>/dev/null 2>&1
sudo usermod -aG games "$(whoami)" >>/dev/null 2>&1

read -n 1 -rp "Which browser would you like to install (f)irefox, (c)hrome, or (b)oth? " browser
echo
case "$browser" in
"f")
    echo "Installing firefox..."
    paru -S --noconfirm --needed firefox >>/dev/null 2>&1
    echo "Finished installing firefox"
    ;;
"c")
    echo "Installing chrome..."
    paru -S --noconfirm --needed google-chrome >>/dev/null 2>&1
    echo "Finished installing chrome"
    ;;
"b")
    echo "Installing firefox and chrome..."
    paru -S --noconfirm --needed firefox google-chrome >>/dev/null 2>&1
    echo "Finished installing firefox and chrome"
    ;;
esac

paru -S --noconfirm --needed npm nodejs >>/dev/null 2>&1
cd ~/.config/chevron
npm install >>/dev/null 2>&1 && npm run build >>/dev/null 2>&1
sudo npm install -g node-linux >>/dev/null 2>&1 && npm link node-linux >>/dev/null 2>&1
sudo npm register_linux >>/dev/null 2>&1
sudo systemctl enable chevron.service >>/dev/null 2>&1

sudo systemctl enable sddm >>/dev/null 2>&1
