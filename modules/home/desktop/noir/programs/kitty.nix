{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    programs.kitty.enable = true;

    desktop.noir.extraBinds = [
      "$mod, Return, exec, kitty"
    ];
  };
}
