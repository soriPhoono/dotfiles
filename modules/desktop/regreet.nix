{ lib, config, ... }:
let cfg = config.desktop.regreet;
in {
  options = {
    desktop.regreet.enable =
      lib.mkEnableOption "Enable regreet display manager";
  };

  config = lib.mkIf cfg.enable { programs.regreet.enable = true; };
}
