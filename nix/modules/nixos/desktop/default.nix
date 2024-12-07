{ lib, config, ... }:
let cfg = config.desktop;
in {
  options.desktop = {
    kde.enable = lib.mkEnableOption "Enable kde desktop environment";
  };

  config = lib.mkIf cfg.kde.enable {
    services.desktopManager.plasma6.enable = true;

    services.displayManager.sddm.enable = true;
  };
}
