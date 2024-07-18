{ lib, pkgs, config, ... }:
let cfg = config.kde;
in {
  options = {
    kde.enable = lib.mkEnableOption "Enable KDE Plasma Desktop";
  };

  config = lib.mkIf cfg.enable {
    services = {
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };

      desktopManager.plasma6.enable = true;
    };

    environment.plasma6.excludePackages = with pkgs; [
      oxygen
    ];
  };
}
