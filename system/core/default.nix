{ config, pkgs, ... }: {
  imports = [
    ./boot.nix
    ./locale.nix
  ];
}
