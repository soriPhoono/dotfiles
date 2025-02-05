{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.noir;
in {
  config = lib.mkIf cfg.enable {
    supporting.hyprland = {
      enable = true;

      extraBinds = [
        "$mod, B, exec, ${pkgs.firefox}/bin/firefox"
      ];
    };
  };
}
