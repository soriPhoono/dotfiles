{
  lib,
  config,
  ...
}: let
  cfg = config.core.hardware.hid.tablet;
in {
  options.core.hardware.hid.tablet.enable = lib.mkEnableOption "Enable opentabletdriver for drawing tablets";

  config = lib.mkIf cfg.enable {
    hardware = {
      uinput.enable = true;
      opentabletdriver.enable = true;
    };
    services.udev.extraRules = builtins.concatStringsSep "\n" [
      "KERNEL==\"uinput\",MODE:=\"0666\",OPTIONS+=\"static_node=uinput\""
      "SUBSYSTEMS==\"usb\",ATTRS{idVendor}==\"28bd\",MODE:=\"0666\""
    ];
  };
}
