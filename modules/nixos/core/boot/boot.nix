{
  lib,
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

  options.core.boot.enable = lib.mkEnableOption "Enable bootloader features";

  config = lib.mkIf cfg.enable {
    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
      };
    };

    zramSwap.enable = true;
  };
}
