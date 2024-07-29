{ lib, pkgs, config, ... }:
let cfg = config.desktop.managers.kde;
in {
  options = {
    desktop.managers.kde.enable = lib.mkEnableOption "Enable KDE Plasma Desktop";
  };

  config = lib.mkIf cfg.enable {
    services = {
      pipewire = lib.mkIf cfg.pipewire.enable {
        enable = true;

        pulse.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        jack.enable = true;
      };

      displayManager.sddm = lib.mkIf cfg.sddm.enable {
        enable = true;

        wayland.enable = true;
      };

      desktopManager.plasma6.enable = true;
    };

    users.users.soriphoono.extraGroups = lib.mkIf cfg.pipewire.enable [
      "audio"
    ];
  };
}
