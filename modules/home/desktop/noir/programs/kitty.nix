{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;

      settings = {
        cursor_shape = "beam";
        cursor_trail = 1;
      };
    };

    wayland.windowManager.hyprland.settings.bind = [
      "$mod, Return, exec, kitty"
    ];
  };
}
