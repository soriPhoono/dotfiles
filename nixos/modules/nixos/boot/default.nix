{ pkgs, ... }: {
  imports = [
    ./systemd-boot.nix
    ./plymouth.nix
  ];

  # boot.kernelPackages = pkgs.linuxPackages_zen;
}
