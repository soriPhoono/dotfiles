{ lib, config, ... }:
let cfg = config.core.hardware.logitech;
in {
  options = {
    core.hardware.logitech = {
      enable = lib.mkEnableOption "Enable Logitech support";
      enableGraphical = lib.mkEnableOption "Enable graphical Logitech support";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.logitech.wireless = {
      enable = true;
      enableGraphical = lib.mkIf cfg.enableGraphical true;
    };
  };
}
