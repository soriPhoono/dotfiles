{ pkgs, ... }: {
  imports = [
    ./nvim.nix
  ];

  home.packages = with pkgs; [
    nil
    nixpkgs-fmt
  ];
}