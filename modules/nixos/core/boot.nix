{ lib, pkgs, config, ... }:
let
  cfg = config.core.boot;
in
{
  options = {
    core.boot.enable = lib.mkEnableOption "Enable systemd-boot bootloader";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      kernelPackages = pkgs.linuxPackages_zen;

      consoleLogLevel = 0;

      kernelParams =
        [ "quiet" "systemd.show_status=auto" "udev.log_level=3" ];

      initrd.verbose = false;

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
          (catppuccin-plymouth.override {
            variant = "mocha";
          })
        ];

        theme = "catppuccin-mocha";
      };

      tmp.cleanOnBoot = true;
    };

    zramSwap.enable = true;
  };
}
