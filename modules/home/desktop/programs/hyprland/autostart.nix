{
  lib,
  config,
  ...
}: let
  cfg = config.hyprland;
in {
  options.hyprland = {
    autostart = lib.mkOption {
      type = with lib.types; listOf str;

      default = [];

      description = "Commands to run on hyprland startup";
    };

    onReload = lib.mkOption {
      type = with lib.types; listOf str;

      default = [];

      description = "Commands to run on hyprland reload";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      exec-once = cfg.autostart;
      exec = cfg.onReload;
    };
  };
}
