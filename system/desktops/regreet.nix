{ config, pkgs, ... }: {
  imports = [
    ../services/greetd.nix
  ];

  services.cage = {
    enable = true;
  };

  programs.regreet = {
    enable = true;
  };
}
