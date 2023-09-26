#!/bin/bash

# Path:         ~/.config/yadm/desktop/bootstrap
# Description:  Bootstrap script for desktop environment
# Author:       Sori Phoono <soriphoono@gmail.com>

packages=(
    "sddm"                        # Display manager
    "sddm-sugar-candy-git"        # SDDM theme
    "xorg-xhost"                  # X11 utility for controlling access to the X server
    "xorg-xauth"                  # X11 authority file management
    "xorg-xinit"                  # X11 initialisation program
    "xorg-xmodmap"                # Utility for modifying keymaps and pointer button mappings in X
    "xdg-desktop-portal"          # Desktop integration portals for sandboxed apps
    "xdg-desktop-portal-gtk"      # GTK backend for xdg-desktop-portal
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
    "dunst"                       # Notification daemon
    "geoclue"                     # Location information
    "redshift"                    # Screen temperature adjustment
    "unclutter"                   # Hides cursor when idle
    "brightnessctl"               # Brightness control
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
        if grep "GST_PLUGIN_FEATURE_RANK" /etc/environment; then
            commands+=("sudo sed -i \"s/GST_PLUGIN_FEATURE_RANK=.*/GST_PLUGIN_FEATURE_RANK=nvmpegvideodec:MAX,nvmpeg2videodec:MAX,nvmpeg4videodec:MAX,nvh264sldec:MAX,nvh264dec:MAX,nvjpegdec:MAX,nvh265sldec:MAX,nvh265dec:MAX,nvvp9dec:MAX\" /etc/environment")
        else
            commands+=("grep \"GST_PLUGIN_FEATURE_RANK=nvmpegvideodec:MAX,nvmpeg2videodec:MAX,nvmpeg4videodec:MAX,nvh264sldec:MAX,nvh264dec:MAX,nvjpegdec:MAX,nvh265sldec:MAX,nvh265dec:MAX,nvvp9dec:MAX\" | sudo tee -a /etc/environment ")
        fi
        ;;
    esac
done

read -p "Enable bluetooth? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages+=("bluez" "bluez-utils" "blueberry")
    commands+=("sudo systemctl enable bluetooth ")
fi

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

echo "Installing packages..."
paru -S --noconfirm --needed "${packages[@]}"
for command in "${commands[@]}"; do
    eval "$command" >/dev/null
done
echo "Finished installing core desktop environment packages"

systemctl --user enable pipewire.service
systemctl --user enable redshift.service

sudo usermod -aG video "$(whoami)"
sudo usermod -aG input "$(whoami)"
sudo usermod -aG disk "$(whoami)"
sudo usermod -aG audio "$(whoami)"
sudo usermod -aG games "$(whoami)"

read -p "Enable chevron start page with chatgpt integration? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd ~/.config/chevron
    npm install && npm run build
    sudo npm install -g node-linux && npm link node-linux
    npm run register_linux
    sudo systemctl enable chevron.service
fi

if [ $(grep -q "QT_QPA_PLATFORMTHEME" /etc/environment) ]; then
    sudo sed -i "s/QT_QPA_PLATFORMTHEME=.*/QT_QPA_PLATFORMTHEME=qt5ct/g" /etc/environment
else
    echo "QT_QPA_PLATFORMTHEME=qt5ct" | sudo tee -a /etc/environment >/dev/null
fi

if [ $(grep -q "TERM" /etc/environment) ]; then
    sudo sed -i "s/TERM=.*/TERM=alacritty/g" /etc/environment
else
    echo "TERM=alacritty" | sudo tee -a /etc/environment >/dev/null
fi

if [ ! $(grep -q "Path askpass" /etc/sudo.conf) ]; then
    echo "Path askpass /usr/local/bin/zenity-passphrase" | sudo tee -a /etc/sudo.conf >/dev/null
fi

sudo touch /etc/udev/rules.d/99-mtp.rules
sudo tee /etc/udev/rules.d/99-mtp.rules >/dev/null <<EOF
# Plug in
ACTION="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="18d1", ENV{XAUTHORITY}="/home/$USER/.Xauthority" RUN+="/usr/bin/su $USER -c '/home/$USER/.local/bin/notifications/mtp-device.sh'"
# Unplug
ACTION=="remove", SUBSYSTEM=="usb", ATTRS{idVendor}=="18d1", ENV{XAUTHORITY}="/home/$USER/.Xauthority" RUN+="/usr/bin/su $USER -c '/home/$USER/.local/bin/notifications/mtp-device.sh'"
EOF

sudo touch /etc/udev/rules.d/99-storage.rules
sudo tee /etc/udev/rules.d/99-storage.rules >/dev/null <<EOF
# Plug in usb drive
KERNEL=="sd?", ACTION=="add", RUN+="/usr/bin/su $USER -c '/home/$USER/.local/bin/notifications/usb.sh'"
# Unplug usb drive
KERNEL=="sd?", ACTION=="remove", RUN+="/usr/bin/su $USER -c '/home/$USER/.local/bin/notifications/usb.sh'"
EOF

sudo touch /etc/udev/rules.d/99-charging.rules
sudo tee /etc/udev/rules.d/99-charging.rules >/dev/null <<EOF
# Battery
ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/$(whoami)/.Xauthority" RUN+="/usr/bin/su $(whoami) -c '/home/$(whoami)/.local/bin/notifications/power-supply.sh 0'"
# AC
ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/$(whoami)/.Xauthority" RUN+="/usr/bin/su $(whoami) -c '/home/$(whoami)/.local/bin/notifications/power-supply.sh 1'"
EOF

touch ~/.config/qt5ct/qt5ct.conf
tee ~/.config/qt5ct/qt5ct.conf >/dev/null <<EOF
[Appearance]
color_scheme_path=/home/$(whoami)/.config/qt5ct/colors/Catppuccin-Mocha.conf
custom_palette=true
icon_theme=Papirus-Dark
standard_dialogs=default
style=Fusion

[Fonts]
fixed="SauceCodeProNFM,12,-1,5,50,0,0,0,0,0"
general="SauceCodeProNF,12,-1,5,50,0,0,0,0,0"

[Interface]
activate_item_on_single_click=1
buttonbox_layout=0
cursor_flash_time=1000
dialog_buttons_have_icons=1
double_click_interval=400
gui_effects=@Invalid()
keyboard_scheme=2
menus_have_icons=true
show_shortcuts_in_context_menus=true
stylesheets=/usr/share/qt5ct/qss/scrollbar-simple.qss
toolbutton_style=4
underline_shortcut=1
wheel_scroll_lines=4

[PaletteEditor]
geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x4\x7f\0\0\x2\x1b\0\0\0\0\0\0\0\0\0\0\x2v\0\0\x2\x10\0\0\0\0\x2\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\x4\x7f\0\0\x2\x1b)

[SettingsWindow]
geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\x4\0\0\0+\0\0\au\0\0\x4-\0\0\x4\x38\0\0\0\x14\0\0\a\x16\0\0\x2\xac\0\0\0\0\x2\0\0\0\a\x80\0\0\0\a\0\0\0.\0\0\ar\0\0\x4*)

[Troubleshooting]
force_raster_widgets=0
ignored_applications=@Invalid()
EOF

touch ~/.config/qt6ct/qt6ct.conf
tee ~/.config/qt6ct/qt6ct.conf >/dev/null <<EOF
[Appearance]
color_scheme_path=/home/soriphoono/.config/qt6ct/colors/Catppuccin-Mocha.conf
custom_palette=true
icon_theme=Stylish-Dark
standard_dialogs=default
style=Fusion

[Fonts]
fixed="SauceCodeProNFM,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
general="SauceCodeProNF,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"

[Interface]
activate_item_on_single_click=1
buttonbox_layout=0
cursor_flash_time=1000
dialog_buttons_have_icons=0
double_click_interval=400
gui_effects=General, FadeMenu, FadeTooltip, AnimateToolBox
keyboard_scheme=2
menus_have_icons=false
show_shortcuts_in_context_menus=true
stylesheets=/usr/share/qt6ct/qss/fusion-fixes.qss, /usr/share/qt6ct/qss/scrollbar-simple.qss, /usr/share/qt6ct/qss/sliders-simple.qss, /usr/share/qt6ct/qss/tooltip-simple.qss, /usr/share/qt6ct/qss/traynotification-simple.qss
toolbutton_style=4
underline_shortcut=1
wheel_scroll_lines=3

[PaletteEditor]
geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\x1\x34\0\0\0y\0\0\x5\xb0\0\0\x4m\0\0\x1\x35\0\0\0z\0\0\x5\xaf\0\0\x4l\0\0\0\0\0\0\0\0\a\x80\0\0\x1\x35\0\0\0z\0\0\x5\xaf\0\0\x4l)

[QSSEditor]
geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\x2|\0\0\x1\\\0\0\x5\x2\0\0\x3R\0\0\x2~\0\0\x1^\0\0\x5\0\0\0\x3P\0\0\0\0\0\0\0\0\a\x80\0\0\x2~\0\0\x1^\0\0\x5\0\0\0\x3P)

[SettingsWindow]
geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\x4\0\0\0+\0\0\au\0\0\x4-\0\0\0\a\0\0\0.\0\0\ar\0\0\x4*\0\0\0\0\0\0\0\0\a\x80\0\0\0\a\0\0\0.\0\0\ar\0\0\x4*)

[Troubleshooting]
force_raster_widgets=1
ignored_applications=@Invalid()
EOF

sudo systemctl enable sddm.service

paru -c --noconfirm >/dev/null
