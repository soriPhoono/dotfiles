{ lib, inputs, pkgs, mkShell, ... }:
mkShell {
  packages = with pkgs; [
    nixfmt

    age
    sops
    ssh-to-age
  ];
}
