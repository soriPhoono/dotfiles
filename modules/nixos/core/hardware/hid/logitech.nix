{
  lib,
  config,
  ...
}: let
  cfg = config.core.hardware.hid.logitech;
in {
  options.core.hardware.hid.logitech.enable = lib.mkEnableOption "Enable logitech drivers";

  config = lib.mkIf cfg.enable {
    hardware.logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };

    # TODO: update udev rules for logitech powerplay charger and g502 mouse
    services.udev.extraRules = ''
      # blacklist for usb autosuspend
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="05c6", ATTR{idProduct}=="9205", GOTO="logitech_power_rules"

      ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="auto"
      LABEL="logitech_power_rules"
    '';
  };
}
