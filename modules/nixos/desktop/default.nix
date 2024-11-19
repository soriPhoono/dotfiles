{ lib, config, ... }:
let cfg = config.desktop;
in {
  imports = [ ./kde.nix ./hyprland.nix ./steam.nix ];

  options = {
    desktop.enable = lib.mkEnableOption "Enable the desktop module";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;

    networking.networkmanager.enable = true;

    programs = {
      partition-manager.enable = true;
      droidcam.enable = true;
    };

    services = {
      upower.enable = true;
      power-profiles-daemon.enable = true;
      
      pipewire = {
        enable = true;

        jack.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };

    users.users.soriphoono.extraGroups = [ "networkmanager" ];
  };
}
