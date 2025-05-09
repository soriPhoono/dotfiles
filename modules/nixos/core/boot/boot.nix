{ lib, pkgs, config, ... }:
let cfg = config.core.boot;
in {
  imports = [
    ./disk.nix

    ./plymouth.nix

    ./secrets.nix
  ];

  config = {
    boot = {
      kernelPackages = pkgs.linuxPackages_zen;

      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };
      };
    };

    zramSwap.enable = true;

    security.sudo.wheelNeedsPassword = false;
  };
}
