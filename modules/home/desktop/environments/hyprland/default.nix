{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.environments.hyprland;
in
  with lib; {
    options.desktop.environments.hyprland = {
      enable = mkEnableOption "Enable hyprland core config, ENABLE THIS OPTION IN YOUR CONFIG";

      custom = mkEnableOption "Enable recognition for custom hyprland configurations, ENABLE THIS OPTION IN YOUR CONFIG";
    };

    config = mkIf cfg.enable {
      desktop.environments.enable = true;

      wayland.windowManager.hyprland.enable = true;
    };
  }
