{ lib, config, ... }:
let cfg = config.desktop.programs.wlogout;
in {
  options = {
    desktop.programs.wlogout.enable = lib.mkEnableOption "Enable wlogout";
  };

  config = lib.mkIf cfg.enable { programs.wlogout = { enable = true; }; };
}
