{ lib, pkgs, config, ... }:
let cfg = config.desktops.programs.gaming;
in {
  options = {
    desktops.programs.gaming.enable = lib.mkEnableOption "Enable gaming programs";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      lutris
      heroic

      bottles

      prismlauncher

      path-of-building
    ];
  };
}
