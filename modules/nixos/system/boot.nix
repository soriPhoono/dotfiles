{ lib, pkgs, config, ... }:
let cfg = config.system.boot;
in {
  options.system.boot = {
    enable = lib.mkEnableOption "Enable the boot loader for systems";

    verbose = lib.mkEnableOption "Enable verbose output for the boot loader";

    kernelParams = lib.mkOption {
      type = lib.types.listOf lib.types.str;

      default = [ ];

      description = ''
        Additional kernel parameters to pass to the boot
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      kernelPackages = pkgs.linuxPackages_zen;

      consoleLogLevel = if cfg.verbose then 4 else 0;

      kernelParams = (if cfg.verbose then [

      ] else [
        "quiet"
        "systemd.show_status=false"
        "udev.log_level=3"
      ]) ++ cfg.kernelParams;

      initrd.verbose = cfg.verbose;

      loader = {
        efi.canTouchEfiVariables = true;

        systemd-boot = {
          enable = true;

          editor = false;
          configurationLimit = 10;
        };
      };

      plymouth.enable = ! cfg.verbose;
    };

    zramSwap.enable = true;
  };
}
