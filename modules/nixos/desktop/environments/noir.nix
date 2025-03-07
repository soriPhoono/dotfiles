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
