{ config, pkgs, ... }: {
  imports = [
    ../services/greetd.nix
  ];

  programs.regreet = {
    enable = true;
  };
}
