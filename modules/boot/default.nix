{ pkgs, ... }: {
  imports = [
    ./systemd-boot.nix
    ./zram-generator.nix
    ./plymouth.nix
  ];
  
  boot.kernelPackages = pkgs.linuxPackages_zen;
}