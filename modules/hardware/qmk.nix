{ lib, config, ... }:
let cfg = config.hardware.qmk_keyboard;
in {
  options = {
    hardware.qmk_keyboard.enable =
      lib.mkEnableOption "Enable QMK keyboard support";
  };

  config = lib.mkIf cfg.enable {
    hardware.keyboard.qmk.enable = lib.mkIf cfg.enable true;
  };
}
