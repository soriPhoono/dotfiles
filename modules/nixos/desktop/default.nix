{ lib, config, ... }:
let cfg = config.desktop;
in {
  imports = [ ./hyprland.nix ./steam.nix ];

  options = {
    desktop.enable = lib.mkEnableOption "Enable desktop related features";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;

    programs.droidcam.enable = true;

    services = {
      gnome.gnome-keyring.enable = true;

      gvfs.enable = true;

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

    networking.networkmanager.enable = true;

    users.users.soriphoono.extraGroups = [ "networkmanager" ];
  };
}
