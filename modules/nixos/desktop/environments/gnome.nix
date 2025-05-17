{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.environments.gnome;
in {
  options.desktop.environments.gnome = {
    enable = lib.mkEnableOption "Enable gnome desktop environment";
  };

  config = lib.mkIf cfg.enable {
    services = {
      displayManager.defaultSession = lib.mkDefault "gnome";
      xserver = {
        displayManager.gdm = {
          enable = true;
          wayland = true;
        };
        desktopManager.gnome.enable = true;
      };
    };

    jovian.steam.desktopSession = "gnome";
  };
}
