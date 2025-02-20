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

    services.udev.extraRules = ''
      ACTION="add", SUBSYSTEM="usb", ATTR{idVendor}="05e3", ATTR{idProduct}="0608", ATTR{power/autosuspend}="-1"
    '';
  };
}
