{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    desktop.noir.extraBinds = [
      "$mod, E, exec, ${pkgs.nautilus}/bin/nautilus"
    ];
  };
}
