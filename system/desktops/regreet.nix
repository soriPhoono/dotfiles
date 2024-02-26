{ config, pkgs, ... }: {
  imports = [
    ../services/greetd.nix
  ];

  programs.regreet = {
    enable = true;
  };

  environment.etc."greetd/hyprland.conf".source
    = ../../config/greetd/hyprland.conf;
}
