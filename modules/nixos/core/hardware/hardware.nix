{ lib, config, ... }:
let cfg = config.core.hardware;
in {
  imports = [
    ./gpu/gpu.nix

    ./hid/qmk.nix
    ./hid/logitech.nix
    ./hid/gamepads.nix

    ./bluetooth.nix
    ./android.nix
  ];

  options.core.hardware = {
    enable = lib.mkEnableOption "Enable hardware support";

    defaultReportPath = lib.mkOption {
      type = lib.types.path;
      description = "The default report path for the system facter report";
    };
  };

  config = {
    facter.reportPath = cfg.defaultReportPath;

    hardware = lib.mkIf cfg.enable {
      ksm.enable = true;
      i2c.enable = true;
    };
  };
}
