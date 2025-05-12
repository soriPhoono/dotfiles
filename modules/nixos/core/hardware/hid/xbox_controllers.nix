{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.core.hardware.hid.xbox_controllers;
in {
  options.${namespace}.core.hardware.hid.xbox_controllers.enable = lib.mkEnableOption "Enable gamepad drivers";

  config = lib.mkIf cfg.enable {
    hardware = {
      xone.enable = true;

      # 🗒️: hardware.xpadneo.enable = true # for xbox one original controllers
    };
  };
}
