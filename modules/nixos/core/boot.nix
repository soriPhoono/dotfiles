{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.boot;
in {
  options.core.boot = {
    enable = lib.mkEnableOption "Enable system boot configuration with systemd-boot and ZRAM swap";
    secure-boot = {
      enable = lib.mkEnableOption "Enable bootloader hardening features";
    };
  };

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
        systemd-boot = lib.mkIf cfg.enable {
          enable = lib.mkForce (!(cfg.enable));
          configurationLimit = 10;
        };
      };

      lanzaboote = {
        enable = cfg.enable;
        pkiBundle = "/var/lib/sbctl";
      };

      plymouth.enable = true;
    };

    zramSwap.enable = true;

    security.sudo.wheelNeedsPassword = false;
  };
}
