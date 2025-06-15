{
  lib,
  pkgs,
  ...
}: {
  networking.wireless.enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    disko
    nixos-facter
  ];

  core = {
    hardware = {
      gpu.enable = true;
      bluetooth.enable = true;
    };

    networking = {
      enable = true;
      network-manager.enable = true;
      tailscale.enable = true;
    };
  };

  desktop.environments.gnome.enable = true;

  themes.catppuccin.enable = true;
}
