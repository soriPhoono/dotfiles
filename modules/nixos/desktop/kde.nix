{ lib, config, ... }:
let cfg = config.desktop.kde;
in {
  options = {
    desktop.kde.enable = lib.mkEnableOption "Enable kde desktop environment";
  };

  config = lib.mkIf cfg.enable {
    desktop.enable = true;

    services.desktopManager.plasma6.enable = true;
  };
}
