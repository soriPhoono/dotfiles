{ lib, pkgs, config, ... }:
let cfg = config.core.boot;
in {
  options = {
    core.boot.enable = lib.mkEnableOption "Enable boot services";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      initrd.supportedFilesystems = [ "ext4" "vfat" "ntfs" "exfat" ];

      kernelPackages = pkgs.linuxPackages_zen;
      kernelModules = [ "tcp_brr" ];
      kernelParams = [ "quiet" "systemd.show_status=auto" "rd.udev.log_level=3" ];

      loader = {
        efi.canTouchEfiVariables = true;

        systemd-boot = {
          enable = true;

          memtest86.enable = true;
        };
      };

      plymouth = {
        enable = true;

        themePackages = with pkgs;
          [
            (adi1090x-plymouth-themes.override { selected_themes = [ "rings" ]; })
          ];

        theme = "rings";
      };

      tmp.cleanOnBoot = true;
    };

    zramSwap.enable = true;
  };
}
