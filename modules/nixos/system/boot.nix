{ lib, pkgs, config, ... }:
let
  this = "system.boot";

  cfg = config."${this}";
in {
  options."${this}" = {
    enable = lib.mkEnableOption "Enable the boot loader for systems";

    plymouth.enable = lib.mkEnableOption "Enable plymouth bootloader animation";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      kernelPackages = pkgs.linuxPackages_zen;

      consoleLogLevel = if (!cfg.plymouth.enable) then 4 else 0;

      kernelParams = (if (!cfg.plymouth.enable) then [

      ] else [
        "quiet"
        "systemd.show_status=false"
        "udev.log_level=3"
      ]);

      initrd.verbose = !cfg.plymouth.enable;

      loader = {
        efi.canTouchEfiVariables = true;

        systemd-boot = {
          enable = true;

          editor = false;
          configurationLimit = 10;
        };
      };

      plymouth.enable = cfg.plymouth.enable;
    };

    zramSwap.enable = true;
  };
}
