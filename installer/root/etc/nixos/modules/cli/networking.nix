{ config, pkgs, ... }: {
  networking = {
    hostName = "home_desktop"; # Set the hostname to ‘nixos’

    networkmanager.enable = true; # Enable NetworkManager to manage network connections
  };
}
