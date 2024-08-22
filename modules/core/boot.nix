{ lib
, pkgs
, config
, ...
}:
let
  cfg = config.core.boot;
in
{
  options = {
    core.boot.systemd-boot.enable = lib.mkEnableOption "Enable bootloader";
  };

  config = lib.mkIf cfg.systemd-boot.enable {
    boot = {
      consoleLogLevel = 0;
      kernelPackages = pkgs.linuxPackages_zen;
      kernelParams = [ "quiet" "systemd.show_status=auto" "rd.udev.log_level=3" ];

      initrd = {
        verbose = false;

        supportedFilesystems = [ "vfat" "ntfs" "apfs" "exfat" ];
      };

      loader = {
        efi.canTouchEfiVariables = true;

        systemd-boot = {
          enable = true;

          editor = false;
        };
      };

      plymouth = {
        enable = true;

        themePackages = with pkgs;
          [
            (adi1090x-plymouth-themes.override { selected_themes = [ "pixels" ]; })
          ];

        theme = "pixels";
      };

      tmp.cleanOnBoot = true;
    };

    zramSwap.enable = true;
  };
}
