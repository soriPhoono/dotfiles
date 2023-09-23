#!/bin/bash

# Path:         ~/.config/yadm/desktop/bootstrap
# Description:  Bootstrap script for desktop environment
# Author:       Sori Phoono <soriphoono@gmail.com>

packages=(
    "sddm"                        # Display manager
    "sddm-sugar-candy-git"        # SDDM theme
    "xorg-xhost"                  # X11 utility for controlling access to the X server
    "xxd-standalone"              # Xxd from vim for .Xauthority creation
    "xorg-xauth"                  # X11 authority file management
    "xorg-xinit"                  # X11 initialisation program
    "xorg-xmodmap"                # Utility for modifying keymaps and pointer button mappings in X
    "xdg-desktop-portal"          # Desktop integration portals for sandboxed apps
    "qtile"                       # Window manager
    "polybar"                     # Status bar
    "picom-ftlabs-git"            # Compositor
    "xidlehook"                   # Idle management daemon
    "qt5-graphicaleffects"        # Qt5 graphicaleffects
    "qt5-quickcontrols2"          # Qt5 quickcontrols2
    "qt5-svg"                     # Qt5 svg
    "rofi"                        # Application launcher
    "betterlockscreen"            # Lockscreen
    "cool-retro-term"             # Terminal emulator for lockscreen effect
    "cmatrix"                     # Terminal emulator for lockscreen effect program
    "redshift"                    # Screen temperature adjustment
    "unclutter"                   # Hides cursor when idle
    "catppuccin-gtk-theme-mocha"  # GTK theme
    "catppuccin-cursors-mocha"    # Cursor theme
    "papirus-icon-theme"          # Icon theme
    "playerctl"                   # Media player control
    "zenity"                      # Dialog boxes
    "imagemagick"                 # Image manipulation
    "cava"                        # Audio visualiser
    "qt5ct"                       # Qt5 configuration utility
    "qt6ct"                       # Qt6 configuration utility
    "nwg-look"                    # GTK theme switcher
    "font-manager"                # Font manager
    "adobe-source-code-pro-fonts" # Monospace font
    "ttf-sourcecodepro-nerd"      # Monospace font
    "ttf-nerd-fonts-symbols"      # Icon font
    "ttf-nerd-fonts-symbols-mono" # Icon font
    "noto-fonts-emoji"            # Emoji font
    "polkit-gnome"                # PolicyKit authentication agent
    "gnome-keyring"               # Keyring
    "alacritty"                   # Terminal emulator
    "gvfs"                        # Virtual filesystem
    "gvfs-afc"                    # Virtual filesystem
    "gvfs-mtp"                    # Virtual filesystem
    "gvfs-gphoto2"                # Virtual filesystem
    "pcmanfm-gtk3"                # File manager
    "file-roller"                 # Archive manager
    "gnome-disk-utility"          # Disk utility
    "gparted"                     # Partition manager
    "bleachbit"                   # System cleaner
    "flameshot"                   # Screenshot utility
    "imv"                         # Image viewer
    "exaile"                      # Music player
    "mpv"                         # Video player
    "vlc"                         # Video player
    "qbittorrent"                 # Torrent client
)

commands=()

packages+=("pipewire" "pipewire-audio" "pipewire-alsa" "pipewire-jack" "pipewire-pulse" "wireplumber" "pavucontrol" "carla" "easyeffects")
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

read -p "Enable bluetooth? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=("bluez bluez-utils blueberry")
    commands+=("sudo systemctl enable bluetooth >>/dev/null 2>&1")
fi

commands+=("echo -e \"TERM=alacritty\nQT_QPA_PLATFORMTHEME=qt6ct\" | sudo tee -a /etc/environment >/dev/null 2>&1")
commands+=("echo \"Path askpass /usr/local/bin/zenity-passphrase\" | sudo tee -a /etc/sudo.conf >/dev/null 2>&1")

commands+=("sudo usermod -aG video "$(whoami)" >>/dev/null 2>&1")
commands+=("sudo usermod -aG input "$(whoami)" >>/dev/null 2>&1")
commands+=("sudo usermod -aG disk "$(whoami)" >>/dev/null 2>&1")
commands+=("sudo usermod -aG audio "$(whoami)" >>/dev/null 2>&1")
commands+=("sudo usermod -aG games "$(whoami)" >>/dev/null 2>&1")

read -n 1 -rp "Which browser would you like to install (f)irefox, (c)hrome, or (b)oth? " browser
echo
case "$browser" in
"f")
    packages+=("firefox")
    ;;
"c")
    packages+=("google-chrome")
    ;;
"b")
    packages+=("firefox" "google-chrome")
    ;;
esac

packages+=("nodejs" "npm")
commands+=("cd ~/.config/chevron")
commands+=("npm install >>/dev/null 2>&1 && npm run build >>/dev/null 2>&1")
commands+=("sudo npm install -g node-linux >>/dev/null 2>&1 && npm link node-linux >>/dev/null 2>&1")
commands+=("sudo npm register_linux >>/dev/null 2>&1")
commands+=("sudo systemctl enable chevron.service >>/dev/null 2>&1")

commands+=("sudo systemctl enable sddm >>/dev/null 2>&1")

echo "Installing packages..."
paru -S --noconfirm --needed "${packages[@]}" >>/dev/null 2>&1
for command in $commands; do
    eval "$command"
done
echo "Finished installing core desktop environment packages"
