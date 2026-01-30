{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.development.editors.antigravity;
in
  with lib; {
    options.userapps.development.editors.antigravity = {
      enable = mkEnableOption "Enable google antigravity AI accelerated coding platform";
    };

    config = mkIf cfg.enable {
      home.packages = [
        pkgs.antigravity
      ];
    };
  }
