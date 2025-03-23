{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.environments.hyprland;
in {
  options.desktop.environments.hyprland = {
    enable = lib.mkEnableOption "Enable hyprland installation";
  };

  config = lib.mkIf cfg.enable {
    core = {
      boot.plymouth.enable = true;

      services = {
        power-profiles-daemon.enable = true;
        upower.enable = true;
        geoclue2.enable = true;
        pipewire.enable = true;
      };
    };

    desktop = {
      programs = {
        regreet.enable = true;
        hyprland.enable = true;
        hyprlock.enable = true;
      };
      services = {
        polkit.enable = true;
        gvfs.enable = true;
        hypridle.enable = true;
      };
    };
  };
}
