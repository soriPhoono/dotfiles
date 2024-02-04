{ config, pkgs, ... }: {
  home.username = "soriphoono";
  home.homeDirectory = "/home/soriphoono";

  home.stateVersion = "23.11";

  home.packages = [
    pkgs.htop
  ];

  programs.home-manager.enable = true;

  programs = {
    git = {
      enable = true; # Enable git

      config = {
        user = {
          name = "soriphoono";
          email = "soriphoono@gmail.com";
        };
      };
    };
  };
}
