{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.environments.hyprland;
in {
  options.desktop.environments.hyprland = {
    enable = lib.mkEnableOption "Enable hyprland desktop environment base.";
  };

  config = lib.mkIf cfg.enable {
    desktop.programs.uwsm = {
      enable = true;
      environments = {
        hyprland = {
          name = "Renderable name of this desktop environment";
          description = "Renderable description of this desktop environment";
          execPath = "${pkgs.hyprland}/bin/Hyprland";
        };
      };
    };

    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
  };
}
