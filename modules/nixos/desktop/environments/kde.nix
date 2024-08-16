{ lib, pkgs, config, ... }:
let cfg = config.desktop.environments.kde;
in {
  imports = [
    ./common/pipewire.nix
  ];

  options = {
    desktop.environments.kde.enable = lib.mkEnableOption "Enable KDE Plasma Desktop";
  };

  config = lib.mkIf cfg.enable {
    desktop.environments.pipewire.enable = true;

    services = {
      displayManager.sddm = {
        enable = true;

        wayland.enable = true;
      };

      desktopManager.plasma6.enable = true;
    };

    users.users.soriphoono.extraGroups = [
      "audio"
    ];
  };
}
