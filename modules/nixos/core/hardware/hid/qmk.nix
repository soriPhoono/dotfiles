{
  lib,
  config,
  ...
}: let
  cfg = config.core.hardware.hid.qmk;
in {
  options.core.hardware.hid.qmk.enable = lib.mkEnableOption "Enable QMK userspace drivers";

  config = lib.mkIf cfg.enable {
    hardware.keyboard.qmk.enable = true;

    # TODO: update udev rules for qmk keyboard
    services.udev.extraRules = ''
      # blacklist for usb autosuspend
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="05c6", ATTR{idProduct}=="9205", GOTO="qmk_power_rules"

      ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="auto"
      LABEL="qmk_power_rules"
    '';
  };
}
