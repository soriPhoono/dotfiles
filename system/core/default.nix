{ config, pkgs, ... }: {
  imports = [
    ./boot.nix
    ./locale.nix
    ./security.nix
    ./users.nix
  ];
}
