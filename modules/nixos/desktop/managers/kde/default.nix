{ lib, pkgs, config, ... }:
let cfg = config.desktop.managers.kde;
in {
  options = {
    desktop.managers.kde.enable = lib.mkEnableOption "Enable KDE Plasma Desktop";
  };

  config = lib.mkIf cfg.enable {
    desktop.managers = {
      pipewire.enable = true;
      sddm.enable = true;
    };

    services.desktopManager.plasma6.enable = true;

    environment.plasma6.excludePackages = with pkgs; [
      oxygen
    ];
  };
}
