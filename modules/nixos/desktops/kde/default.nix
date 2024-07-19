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

      pipewire = {
        enable = true;

        pulse.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        jack.enable = true;
      };
    };

    environment.plasma6.excludePackages = with pkgs; [
      oxygen
    ];

    users.users.soriphoono.extraGroups = [
      "audio"
    ];
  };
}
