{ config, pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ./modules/boot.nix
  ];

  programs = {
    hyprland.enable = true;
  };

  services.pipe

  xdg.portal.wlr.enable = true;

  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      rebootWindow = {
        lower = "03:00";
        upper = "05:00";
      };
    };
  };
}
