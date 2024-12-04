{ lib, config, ... }:
let cfg = config.cli.hardware.inputs;
in {
  options.cli.hardware.inputs = {
    qmk.enable = lib.mkEnableOption "Enable QMK support";

    logitech.enable = lib.mkEnableOption "Enable Logitech support";

    xbox.enable = lib.mkEnableOption "Enable Xbox controller support";
  };

  config.hardware = {
    logitech.wireless = lib.mkIf cfg.logitech.enable {
      enable = true;
      enableGraphical = true;
    };

    keyboard.qmk.enable = lib.mkIf cfg.qmk.enable true;

    xone.enable = lib.mkIf cfg.xbox.enable true;
  };
}
