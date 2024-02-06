{ pkgs, ... }: {
  imports = [
    ./shells/zsh.nix
    ./starship.nix
  ];
}
