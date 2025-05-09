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
      uinput.enable = true; # Generic gamepad support on wayland

      steam-hardware.enable = true; # General controller support for Steam

      xone.enable = true; # Xbox One controller support
    };
  };
}
