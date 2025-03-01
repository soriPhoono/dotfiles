{
  lib,
  config,
  ...
}: let
  cfg = config.core.boot.plymouth;
in {
  options.core.boot.plymouth.enable = lib.mkEnableOption "Enable plymouth boot animation";

  config.boot = lib.mkIf (config.core.boot.enable && cfg.enable) {
    kernelParams = [
      "quiet"
      "systemd.show_status=false"
      "udev.log_level=3"
    ];

    initrd.verbose = false;

    consoleLogLevel = 0;

    plymouth.enable = true;
  };
}
