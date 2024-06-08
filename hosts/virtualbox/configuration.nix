{ pkgs, vars, ... }: {
  imports = [
    ../../modules/nixos/boot
    ../../modules/nixos/core

    ../../modules/nixos/programs/gpg.nix
    ../../modules/nixos/programs/wine.nix
    ../../modules/nixos/programs/gamemode.nix
    ../../modules/nixos/programs/prism-launcher.nix
    ../../modules/nixos/programs/steam.nix
  ];
}
