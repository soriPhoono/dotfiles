{ lib, config, ... }:
let
  cfg = config.core.hardware.qmk;
in {
  options = {
    core.hardware.qmk.enable = lib.mkEnableOption "Enable qmk firmware";
  };

  config = lib.mkIf cfg.enable {
    hardware.keyboard.qmk.enable = true;
  };
}
