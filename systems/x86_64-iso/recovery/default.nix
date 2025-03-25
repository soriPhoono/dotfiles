{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    disko
    nixos-facter
  ];

  core = {
    boot.secrets.defaultSopsFile = ./vault.yaml;

    hardware = {
      enable = true;

      bluetooth.enable = true;
    };

    networking = {
      enable = true;
      wireless.enable = true;
      tailscale.enable = true;
    };
  };

  desktop.environments.hyprland.enable = true;

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
