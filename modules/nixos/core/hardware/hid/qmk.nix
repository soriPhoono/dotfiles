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

    services.udev.extraRules = ''
      ACTION="add", SUBSYSTEM="usb", ATTR{idVendor}="1462", ATTR{idProduct}="7e06", ATTR{power/autosuspend}="-1"
    '';
  };
}
