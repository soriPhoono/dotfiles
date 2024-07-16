{ lib, config, ... }:
let cfg = config.opengl;
in {
  options = {
    opengl.enable = lib.mkEnableOption "Enable opengl drivers";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
