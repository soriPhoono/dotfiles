{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.secure-boot;
in {
  options.core.secure-boot = {
    enable = lib.mkEnableOption "Enable bootloader hardening features";
  };

  config = {
    boot = {
      kernelPackages = pkgs.linuxPackages_zen;
      kernelParams = [
        "quiet"
        "systemd.show_status=false"
        "udev.log_level=3"
        "systemd.unified_cgroup_hierarchy=false"
      ];

      initrd = {
        verbose = false;
        systemd.enable = true;
      };

      consoleLogLevel = 0;

      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot = {
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
