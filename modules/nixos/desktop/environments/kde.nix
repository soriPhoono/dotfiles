{ lib, config, username, ... }:
let cfg = config.desktop.environments.kde;
in {
  options = {
    desktop.environments.kde.enable = lib.mkEnableOption "Enable kde desktop environment";
  };

  config = lib.mkIf cfg.enable {
    desktop = {
      services = {
        sddm = {
          enable = true;
        };

        pipewire.enable = true;
      };
    };

    programs = {
      partition-manager.enable = true;
    };

    services = {
      desktopManager.plasma6 = {
        enable = true;
      };

      power-profiles-daemon.enable = true;
    };

    networking.networkmanager.enable = true;

    users.users.${username}.extraGroups = [ "networkmanager" ];
  };
}
