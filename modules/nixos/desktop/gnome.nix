{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.gnome;
in {
  options.desktop.gnome = {
    enable = lib.mkEnableOption "Enable kde desktop environment";
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
