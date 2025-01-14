{ lib, pkgs, config, ... }:
let cfg = config.system.boot;
in {
  options.system.boot = {
    enable = lib.mkEnableOption "Enable boot configuration";

    plymouth.enable = lib.mkEnableOption "Enable Plymouth boot splash screen";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      kernelPackages = pkgs.linuxPackages_zen;
      kernelParams = if (!cfg.plymouth.enable) then [

      ] else [
        "quiet"
        "systemd.show_status=false"
        "udev.log_level=3"
      ];

      initrd.verbose = !cfg.plymouth.enable;

      consoleLogLevel = if (!cfg.plymouth.enable) then 4 else 0;

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
