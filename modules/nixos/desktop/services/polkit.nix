{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.services.polkit;
in {
  options.desktop.services.polkit.enable = lib.mkEnableOption "Enable gnome-polkit";

  config = lib.mkIf cfg.enable {
    security = {
      polkit.enable = true;
      soteria.enable = true;
    };

    services.seatd.enable = true;
  };
}
