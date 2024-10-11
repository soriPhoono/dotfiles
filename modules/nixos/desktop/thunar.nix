{ lib, pkgs, config, ... }:
let cfg = config.desktop.thunar;
in {
  options = {
    desktop.thunar.enable = lib.mkEnableOption "Enable Thunar";
  };

  config = lib.mkIf cfg.enable {
    programs.thunar = {
      enable = true;

      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };
}
