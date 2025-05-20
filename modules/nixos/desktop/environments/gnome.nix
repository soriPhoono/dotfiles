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
    environment.systemPackages = with pkgs.gnomeExtensions; [
      dash-to-dock
      blur-my-shell
      status-icons
      removable-drive-menu
    ];

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
