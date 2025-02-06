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

      shellIntegration.enableFishIntegration = config.core.shells.fish.enable;

      settings = {
        cursor_shape = "beam";
        cursor_trail = 1;
      };
    };

    desktop.noir.extraBinds = [
      "$mod, Return, exec, kitty"
    ];
  };
}
