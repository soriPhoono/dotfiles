{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    programs.wofi.enable = true;

    desktop.noir.extraBinds = [
      "$mod, A, exec, wofi --show drun"
    ];
  };
}
