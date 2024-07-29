{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs.gaming;
in {
  options = {
    desktop.programs.gaming.enable = lib.mkEnableOption "Enable gaming programs";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gzdoom

      prismlauncher

      path-of-building
    ];
  };
}
