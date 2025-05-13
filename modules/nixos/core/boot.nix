{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.boot;
in {
  options.core.boot.enable = lib.mkEnableOption "Enable bootloader";

  config = lib.mkIf cfg.enable {
    boot = {
      kernelPackages = pkgs.linuxPackages_zen;
      kernelParams = [
        "quiet"
        "systemd.show_status=false"
        "udev.log_level=3"
      ];

      initrd = {
        verbose = false;
        systemd.enable = true;
      };

      consoleLogLevel = 0;

      loader = {
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
