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
    desktop = {
      programs = {
        regreet.enable = true;
        hyprland.enable = true;
        hyprlock.enable = true;
      };
      services = {
        hypridle.enable = true;
        polkit.enable = true;
        gvfs.enable = true;
      };
    };
  };
}
