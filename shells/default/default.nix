{
  lib,
  inputs,
  pkgs,
  mkShell,
  ...
}:
mkShell {
  packages = with pkgs; [
    nixd
    nixfmt

    age
    sops
    ssh-to-age
  ];
}
