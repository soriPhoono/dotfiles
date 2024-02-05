{ config, pkgs, user, ... }: {
  imports =
    [(import ./hardware-configuration.nix)] ++ # Include the hardware-configuration.nix file
    [(import ../../modules/desktop/wm/hyprland.nix)] ++ # Include the hyprland module
    (import ../../modules/userspace); # Include the userspace module (for desktop utilities)

  boot.loader.timeout = 1;

  networking = {
    hostName = "home_desktop";
  };

  environment = {
    systemPackages = with pkgs; [

    ];
  };

  # TODO: setup extra programs and services for system level applications on desktop based systems
}
