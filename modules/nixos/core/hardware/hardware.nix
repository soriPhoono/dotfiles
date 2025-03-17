{
  lib,
  config,
  ...
}: let
  cfg = config.core.hardware;
in {
  imports = [
    ./gpu/gpu.nix

    ./hid/qmk.nix
    ./hid/logitech.nix
    ./hid/gamepads.nix

    ./monitors.nix
    ./bluetooth.nix

    ./android.nix
  ];

  options.core.hardware.enable = lib.mkEnableOption "Enable hardware support";

  config = lib.mkIf cfg.enable {
    hardware = {
      ksm.enable = true;
      i2c.enable = true;
    };
  };
}
