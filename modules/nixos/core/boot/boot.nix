{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.boot;
in {
  imports = [
    ./security.nix

    ./disk.nix
    ./impermanence.nix
    ./secure-boot.nix

    ./plymouth.nix

    ./secrets.nix
  ];

  options.core.boot.enable =
    lib.mkEnableOption "Enable bootloader features"
    // {
      default = true;
    };

  config = lib.mkIf cfg.enable {
    boot = {
      kernelPackages = pkgs.linuxPackages_zen;
      kernelParams = [
        "usbcore.autosuspend=-1"
      ];

      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
      };
    };

    zramSwap.enable = true;
  };
}
