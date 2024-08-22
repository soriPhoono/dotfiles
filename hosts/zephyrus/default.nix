{ inputs
, ...
}: {
  imports = with inputs; [
    ./hardware-configuration.nix

    nixos-hardware.nixosModules.asus-zephyrus-ga401
  ];

  core.boot.systemd-boot.enable = true;
}