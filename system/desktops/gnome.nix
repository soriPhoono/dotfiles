{ config, pkgs, ... }: {
  imports = [
    ./gdm.nix
  ];

  services = {
    xserver = {
      enable = true;

      layout = "us";
      xkbVariant = "";

      libinput.enable = true;

      desktopManager = {
        gnome.enable = true;
      };
    };
  };
}
