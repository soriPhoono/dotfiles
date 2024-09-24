# shell.nix

{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell
{
  nativeBuildInputs = with pkgs; [
    nil
  ];

  shellHook = ''
    fish
  '';
}
