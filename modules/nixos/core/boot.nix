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
        type = lib.types.listOf lib.types.string;
        default = [ ];
        description = ''
          Additional kernel parameters to pass to the kernel.
        '';
      };

      plymouth = {
        enable = lib.mkEnableOption "Enable plymouth boot splash";

        theme = lib.mkOption {
          type = lib.types.str;
          default = "mocha";
          description = ''
            The variant of the plymouth theme to use.
          '';
        };
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

      plymouth = lib.mkIf cfg.plymouth.enable {
        enable = true;

        themePackages = with pkgs; [
          (catppuccin-plymouth.override {
            inherit (cfg.plymouth.theme) variant;
          })
        ];

        theme = cfg.plymouth.theme.name;
      };
    };

    zramSwap.enable = true;
  };
}
