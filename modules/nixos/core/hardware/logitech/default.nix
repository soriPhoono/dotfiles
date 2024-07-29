{ lib, config, ... }:
let cfg = config.core.hardware.logitech;
in {
  options = {
    core.hardware.logitech = {
      enable = lib.mkEnableOption "Enable Bluetooth support";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };
}
