{ config, pkgs, ... }: {
  imports = [
    ./zsh.nix
    ./git.nix
  ];
}
