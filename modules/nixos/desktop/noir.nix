{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  options.desktop.noir = {
    enable = lib.mkEnableOption "Enable hyprland installation";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      hyprland.enable = true;

      hyprlock.enable = true;
    };

    services = {
      hypridle.enable = true;
    };
  };
}
