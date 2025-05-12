{
  lib,
  config,
  ...
}: let
  cfg = config.core.hardware.hid.gamepads;
in {
  options.core.hardware.hid.gamepads.enable = lib.mkEnableOption "Enable gamepad drivers";

  config = lib.mkIf cfg.enable {
    hardware = {
      uinput.enable = true;
      steam-hardware.enable = true;
      xone.enable = true;

      # 🗒️: hardware.xpadneo.enable = true # for xbox one original controllers
    };
  };
}
