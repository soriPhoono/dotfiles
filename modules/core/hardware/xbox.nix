{ lib, config, ... }:
let cfg = config.core.hardware.qmk_keyboard;
in {
  options = {
    core.hardware.qmk_keyboard.enable = lib.mkEnableOption "Enable QMK keyboard support";
  };

  config = lib.mkIf cfg.enable {
    hardware = {
      xone.enable = true;
      steam-hardware.enable = true;
      uinput.enable = true;
    };
  };
}
