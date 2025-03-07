{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.environments.noir;
in {
  options.desktop.environments.noir = {
    enable = lib.mkEnableOption "Enable hyprland installation";
  };

  config = lib.mkIf cfg.enable {
    desktop = {
      programs = {
        regreet.enable = true;
        hyprlock.enable = true;
      };
      services.hypridle.enable = true;
    };

    security.polkit.enable = true;

    programs.hyprland.enable = true;

    services = {
      seatd.enable = true;

      gvfs.enable = true;
    };
  };
}
