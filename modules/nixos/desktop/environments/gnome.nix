{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.environments.gnome;
in {
  options.desktop.environments.gnome.enable = lib.mkEnableOption "Enable Gnome desktop environment";

  config = lib.mkIf cfg.enable {
    core = {
      boot.plymouth.enable = true;
    };

    desktop = {
      services.gdm.enable = true;
    };

    services.xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
