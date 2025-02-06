{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    programs.fuzzel.enable = true;

    desktop.noir.extraBinds = [
      "$mod, A, exec, fuzzel"
    ];
  };
}
