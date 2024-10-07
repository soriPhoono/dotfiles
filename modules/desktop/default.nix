{ lib, config, username, ... }:
let cfg = config.desktop;
in {
  imports = [ ./boot.nix ./dm ./wm ./programs ];

  options = { desktop.enable = lib.mkEnableOption "Enable desktop support"; };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;

    services = {
      pipewire = {
        enable = true;

        jack.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      gvfs.enable = true;

      udisks2.enable = true;
    };

    networking.networkmanager.enable = true;

    users.users.${username}.extraGroups = [ "networkmanager" ];
  };
}
