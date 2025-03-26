{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.environments.gnome;
in {
  options.desktop.environments.gnome.enable = lib.mkEnableOption "Enable gnome home manager configurations";

  config = lib.mkIf cfg.enable {
    desktop = {
      programs.nautilus.enable = true;
      services.gnome-keyring.enable = true;
    };
  };
}
