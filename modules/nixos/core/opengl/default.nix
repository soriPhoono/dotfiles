{ lib, config, ... }:
let cfg = config.core.opengl;
in {
  options = {
    core.opengl.enable = lib.mkEnableOption "Enable opengl drivers";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
