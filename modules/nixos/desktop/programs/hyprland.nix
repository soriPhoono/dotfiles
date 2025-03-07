{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.programs.hyprland;
in {
  options.desktop.programs.hyprland.enable = lib.mkEnableOption "Enable hyprland";

  config = lib.mkIf cfg.enable {
    programs.hyprland.enable = true;
  };
}
