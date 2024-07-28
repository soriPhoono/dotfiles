{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs.util.wlogout;
in {
  options = {
    desktop.programs.util.wlogout = {
      enable = lib.mkEnableOption "Enable wlogout screen";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.wlogout = {
      enable = true;
    };
  };
}
