{ inputs, pkgs, ... }:
pkgs.mkShell {
  packages = with pkgs; [
    nixfmt

    nixos-facter

    age
    ssh-to-age
    sops
  ];
}
