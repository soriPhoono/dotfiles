{
  lib,
  config,
  ...
}: let
  cfg = config.environments.hyprland.default;
in with lib; {
  imports = [
    ./librewolf.nix
  ];

  config = mkIf cfg.enable {
    userapps = {
      terminal.kitty.enable = true;
    };

    wayland.windowManager.hyprland.settings.bind = [
      "$mod, Return, exec, kitty"

      "$mod, Escape, exec, uwsm stop"
    ];
  };
}
