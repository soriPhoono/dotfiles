{
  lib,
  config,
  ...
}: let
  cfg = config.environments.hyprland.default;
in with lib; {
  config = mkIf cfg.enable {
    userapps = {
      librewolf.enable = true;

      terminal.kitty.enable = true;
    };

    wayland.windowManager.hyprland.settings.bind = [
      "$mod, Return, exec, kitty"

      "$mod, B, exec, librewolf"

      "$mod, Escape, exec, uwsm stop"
    ];
  };
}
