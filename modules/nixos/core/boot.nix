{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.boot;
in {
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
        systemd.enable = true;
      };

      consoleLogLevel = 0;

      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot = {
          enable = lib.mkForce false;
          configurationLimit = 10;
        };
      };

      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };

      plymouth.enable = true;
    };

    zramSwap.enable = true;

    security.sudo.wheelNeedsPassword = false;
  };
}
