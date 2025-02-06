{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.soriphoono;
in {
  config = lib.mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;

      settings = {
        main = {
          terminal = "${pkgs.kitty}/bin/kitty";
          layer = "overlay";
        };
      };
    };
  };
}
