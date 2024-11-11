{ lib, config, ... }:
let
  cfg = config.desktop.qt;
in {
  options = {
    desktop.qt.enable = lib.mkEnableOption "Enable qt configuration";
  };

  config = lib.mkIf cfg.enable {
    qt.enable = true;
  };
}