{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.boot;
in {
  options.core.boot.enable = lib.mkEnableOption "Enable bootloader";

  config = {
    boot = {
      kernelPackages = pkgs.linuxPackages_zen;
      kernelParams = [
        "quiet"
        "systemd.show_status=false"
        "udev.log_level=3"
      ];

      initrd = {
        verbose = false;
        systemd.enable = lib.mkIf cfg.enable true;
      };

      consoleLogLevel = 0;

      loader = lib.mkIf cfg.enable {
        efi.canTouchEfiVariables = true;
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };
      };

      plymouth.enable = true;
    };

    zramSwap.enable = true;

    security.sudo.wheelNeedsPassword = false;
  };
}
