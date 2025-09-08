{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.environments.kde;
in {
  options.desktop.environments.kde = {
    enable = lib.mkEnableOption "Enable kde desktop environment";
  };

  config = lib.mkIf cfg.enable {
    desktop.enable = true;

    environment = {
      sessionVariables.NIXOS_OZONE_WL = "1";

      systemPackages = with pkgs; [
        kdePackages.discover
        kdePackages.ksystemlog
      ];
    };

    services = {
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
      desktopManager.plasma6.enable = true;
    };
  };
}
