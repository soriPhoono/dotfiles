{ lib, config, ... }:
let cfg = config.core.hardware.graphics;
in {
  options = {
    core.hardware.graphics = {
      enable = lib.mkEnableOption "Enable OpenGL support";
    };
  };

  config = {
    hardware.graphics = lib.mkIf cfg.enable {
      enable = true;
      enable32Bit = true;
    };
  };
}
