{ lib, pkgs, config, ... }:
let
  cfg = config.core.boot;
in
{
  options = {
    core.boot = {
      enable = lib.mkEnableOption "Enable systemd-boot bootloader";

      debug = lib.mkEnableOption "Enable debug output for the kernel";

      kernelParams = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = ''
          Additional kernel parameters to pass to the kernel.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      kernelPackages = lib.mkDefault pkgs.linuxPackages_zen;

      consoleLogLevel = if cfg.debug then 4 else 0;

      kernelParams = (
        if cfg.debug then
          [ ]
        else
          [ "quiet" "systemd.show_status=auto" "udev.log_level=3" ]
      ) ++ cfg.kernelParams;

      initrd.verbose = cfg.debug;

      loader = {
        efi.canTouchEfiVariables = true;

        systemd-boot = {
          enable = true;

          editor = false;
          configurationLimit = 10;
        };
      };

      plymouth.enable = ! cfg.debug;
    };

    zramSwap.enable = true;
  };
}
