{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.development.antigravity;
in
  with lib; {
    options.userapps.development.antigravity = {
      enable = mkEnableOption "Enable google antigravity AI accelerated coding platform";
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        antigravity
      ];
    };
  }
