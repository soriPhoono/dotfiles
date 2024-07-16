{ lib, config, ... }:
let cfg = config.hardware.graphics;
in {
  options = {
    hardware.graphics.enable = lib.mkEnableOption "Enable graphics drivers";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
