#!/bin/bash

packages=(
    "networkmanager"             # network manager
    "networkmanager-openvpn"     # openvpn plugin for network manager
    "networkmanager-openconnect" # openconnect plugin for network manager
    "ufw"                        # uncomplicated firewall
)

echo "Installing networking packages..."
paru -S --noconfirm --needed "${packages[@]}"

# Enable network manager on boot
sudo systemctl enable NetworkManager.service >/dev/null

# Enable firewall
sudo systemctl enable ufw.service >/dev/null
sudo ufw default deny >/dev/null                                                                                                                                    # deny all incoming connections by default
sudo ufw allow from "$(ip -json route get 8.8.8.8 | jq -r '.[].prefsrc' | sed 's/\([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.\)[0-9]\{1,3\}$/\10\/24/')" >/dev/null # Allow local network connection
sudo ufw enable >/dev/null                                                                                                                                          # enable firewall

read -p "Enable NetworkManager advanced features (tor, i2p, dnscrypt proxy)? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    TORCHROOT="/opt/torchroot"

    advanced_packages=(
        "dnsmasq"        # dns routing
        "dnscrypt-proxy" # dns encryption proxy
        "tor"            # tor
        "i2pd"           # i2p
    )

    echo "Installing advanced networking packages..."
    paru -S --noconfirm --needed "${advanced_packages[@]}"

    # Copy config files
    sudo cp -r ~/.config/yadm/cli/conf/* /

    # Create config structure
    sudo mkdir -p $TORCHROOT
    sudo mkdir -p $TORCHROOT/etc/tor
    sudo mkdir -p $TORCHROOT/dev
    sudo mkdir -p $TORCHROOT/usr/bin
    sudo mkdir -p $TORCHROOT/usr/lib
    sudo mkdir -p $TORCHROOT/usr/share/tor
    sudo mkdir -p $TORCHROOT/var/lib
    sudo mkdir -p $TORCHROOT/var/log/tor/

    # Copy files + create symlinks
    sudo ln -s /usr/lib $TORCHROOT/lib
    sudo cp /etc/hosts $TORCHROOT/etc/
    sudo cp /etc/host.conf $TORCHROOT/etc/
    sudo cp /etc/localtime $TORCHROOT/etc/
    sudo cp /etc/nsswitch.conf $TORCHROOT/etc/
    sudo cp /etc/resolv.conf $TORCHROOT/etc/

    sudo cp /usr/bin/tor $TORCHROOT/usr/bin/
    sudo cp /usr/share/tor/geoip* $TORCHROOT/usr/share/tor/
    sudo cp /lib/libnss* /lib/libnsl* /lib/ld-linux-*.so* /lib/libresolv* /lib/libgcc_s.so* $TORCHROOT/usr/lib/
    sudo cp $(ldd /usr/bin/tor | awk '{print $3}' | grep --color=never "^/") $TORCHROOT/usr/lib/

    sudo cp -r /var/lib/tor $TORCHROOT/var/lib/
    sudo cp /etc/tor/torrc $TORCHROOT/etc/tor/

    # Create permission structure
    sudo chown tor:tor $TORCHROOT
    sudo chmod 700 $TORCHROOT
    sudo chown -R tor:tor $TORCHROOT/var/lib/tor
    sudo chown -R tor:tor $TORCHROOT/var/log/tor

    # Write passwd and group files
    sudo sh -c "grep --color=never ^tor /etc/passwd > $TORCHROOT/etc/passwd" >/dev/null
    sudo sh -c "grep --color=never ^tor /etc/group > $TORCHROOT/etc/group" >/dev/null

    # Create device nodes
    sudo mknod -m 644 $TORCHROOT/dev/random c 1 8
    sudo mknod -m 644 $TORCHROOT/dev/urandom c 1 9
    sudo mknod -m 666 $TORCHROOT/dev/null c 1 3

    # Link linux dynamic loader
    if [ "$(uname -m)" = "x86_64" ]; then
        sudo cp /usr/lib/ld-linux-x86-64.so* $TORCHROOT/usr/lib/.
        sudo ln -sr /usr/lib64 $TORCHROOT/lib64
        sudo ln -s $TORCHROOT/usr/lib ${TORCHROOT}/usr/lib64
    fi

    # Copy configuration files
    sudo cp -r ~/.config/yadm/cli/conf/* /

    # Enable services
    sudo systemctl enable --now dnscrypt-proxy.service >/dev/null
    sudo systemctl enable --now tor.service >/dev/null
    sudo systemctl enable --now i2pd.service >/dev/null

    echo "Configured internet anonymizing features"
fi

echo "Configured networking"

paru -c --noconfirm >/dev/null
