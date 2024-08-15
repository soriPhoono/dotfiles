{ lib, config, ... }:
let cfg = config.core.hardware.graphics;
in {
  options = {
    core.hardware.graphics = {
      enable = lib.mkEnableOption "Enable Bluetooth support";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
