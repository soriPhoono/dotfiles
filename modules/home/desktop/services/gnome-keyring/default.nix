{ lib, config, ... }:
let cfg = config.desktop.services.gnome-keyring;
in {
  options = {
    desktop.services.gnome-keyring.enable = lib.mkEnableOption "Enable gnome keyring";
  };

  config = lib.mkIf cfg.enable {
    security.pam.services.soriphoono.enableGnomeKeyring = true;
    services.gnome.gnome-keyring.enable = true;
  };
}
