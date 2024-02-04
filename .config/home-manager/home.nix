{ config, pkgs, ... }: {
  imports = [

  ];

  home.username = "soriphoono";
  home.homeDirectory = "/home/soriphoono";

  home.stateVersion = "23.11";

  home.packages = [

  ];

  programs.home-manager.enable = true;

  programs = {
    bat = {
      enable = true;

      extraPackages = with pkgs.bat-extras; [
        batman
        batpipe
        batgrep
        batdiff
        batwatch
        prettybat
      ];
    };

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
