{ lib, pkgs, config, ... }:
let cfg = config.services.kde;
in {
  options = {
    kde.enable = lib.mkEnableOption "Enable KDE Plasma Desktop";
  };

  config = {
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
