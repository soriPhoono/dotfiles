{ pkgs, user, ... }: {
  imports = [
    ../modules/cli
  ];

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      dua # Install the dua disk usage analyzer
      duf # Install the duf disk usage finder
      tre-command # Install the tre command
      scc # Install the scc command
    ];

    stateVersion = "23.11";
  };

  programs = {
    eza = {
      enable = true;

      enableAliases = true;

      icons = true;
      git = true;
    };

    bat = {
      enable = true;

      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
      ];
    };

    jq.enable = true;

    git = {
      enable = true;

      userName =

      diff-so-fancy = {
        enable = true;
      };
    };

    home-manager.enable = true;
  };

  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
