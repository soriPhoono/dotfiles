{ config, pkgs, ... }: {
  services.xserver = {
    enable = true;

    layout = "us";
    xkbVariant = "";

    displayManager = {
      gdm.enable = true;
    };

    desktopManager = {
      gnome.enable = true;
    };
  };
}
