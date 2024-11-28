{ pkgs, mkShell, ... }:
mkShell {
  packages = with pkgs; [
    nixd
    nixpkgs-fmt
  ];
}
