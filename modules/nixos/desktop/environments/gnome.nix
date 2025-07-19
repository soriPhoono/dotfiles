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
    environment = {
      sessionVariables.NIXOS_OZONE_WL = "1";

      systemPackages = with pkgs.gnomeExtensions; [
        dash-to-dock
        removable-drive-menu
      ];
    };

    services = {
      displayManager = {
        defaultSession = lib.mkDefault "gnome";
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      desktopManager.gnome.enable = true;
    };
  };
}
