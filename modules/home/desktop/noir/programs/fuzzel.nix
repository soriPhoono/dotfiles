{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    programs.fuzzel.enable = true;

    wayland.windowManager.hyprland.settings.bind = [
      "$mod, A, exec, fuzzel"
    ];
  };
}
