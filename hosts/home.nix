{ pkgs, user, ... }: {
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      dua # Install the dua disk usage analyzer
      duf # Install the duf disk usage finder
      tre-command # Install the tre command
      scc # Install the scc command
    ];

    shellAliases = {
      ls = "eza"; # Use eza as the replacement for ls
      cat = "bat"; # Use bat as the replacement for cat
      du = "dua"; # Use dua as the replacement for du
      df = "duf"; # Use duf as the replacement for df
      tree = "tre"; # Use tre as the replacement for tree
      clock = "scc"; # Use scc as the replacement for clock
    };

    stateVersion = "23.11";
  };

  programs = {
    zsh.history.extended = true;

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

      userName = "${user}";
      userEmail = "${user}@gmail.com";

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
