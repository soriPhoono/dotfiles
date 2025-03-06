{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.services.gnome-keyring;
in {
  options.desktop.services.gnome-keyring.enable = lib.mkEnableOption "Enable Gnome keyring";

  config = lib.mkIf cfg.enable {
    services.gnome-keyring.enable = true;
  };
}
