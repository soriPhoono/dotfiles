{ lib, inputs, pkgs, mkShell, ... }: mkShell {
  packages = with pkgs; [
    nixfmt
  ];
}
