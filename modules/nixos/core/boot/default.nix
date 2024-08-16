{ lib, pkgs, config, ... }:
let cfg = config.core.boot;
in {
  options = {
    core.boot.enable = lib.mkEnableOption "Enable boot services";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      consoleLogLevel = 0;
      kernelPackages = pkgs.linuxPackages_zen;
      kernelParams = [ "quiet" "systemd.show_status=auto" "rd.udev.log_level=3" ];

      initrd = {
        verbose = false;

        supportedFilesystems = [ "vfat" "btrfs" "ntfs" "apfs" "exfat" ];
      };

      loader = {
        efi.canTouchEfiVariables = true;

        systemd-boot = {
          enable = true;
          memtest86.enable = true;

          editor.enable = false;
        };
      };

      plymouth = {
        enable = true;

        themePackages = with pkgs;
          [
            (adi1090x-plymouth-themes.override { selected_themes = [ "rings" ]; })
          ];

        theme = "pixels";
      };

      tmp.cleanOnBoot = true;
    };

    zramSwap.enable = true;
  };
}
