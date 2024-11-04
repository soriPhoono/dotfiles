{ lib, pkgs, config, ... }:
let
  cfg = config.core.boot;
in
{
  options = {
    core.boot = {
      kernelParams = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
      };
    };
  };

  config = {
    boot = {
      consoleLogLevel = 0;
      kernelPackages = pkgs.linuxPackages_zen;
      kernelParams =
        [ "quiet" "systemd.show_status=auto" "rd.udev.log_level=3" ] ++ cfg.kernelParams;

      supportedFilesystems = [ "vfat" "ntfs" "apfs" "exfat" ];

      initrd = {
        verbose = false;

        supportedFilesystems = [ "vfat" "ntfs" "apfs" "exfat" ];
      };

      loader = {
        efi.canTouchEfiVariables = true;

        systemd-boot = {
          enable = true;

          editor = false;
          configurationLimit = 10;
        };
      };

      plymouth = {
        enable = true;

        themePackages = with pkgs; [
          plymouth-proxzima-theme
        ];

        theme = "proxzima";
      };

      tmp.cleanOnBoot = true;
    };

    zramSwap.enable = true;
  };
}
