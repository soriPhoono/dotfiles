{ pkgs, username, ... }: {
  home = {
    packages = with pkgs; [
      dua # Install the dua disk usage analyzer
      duf # Install the duf disk usage finder
      tre-command # Install the tre command
      scc # Install the scc command
    ];

    shellAliases = {
      cat = "bat"; # Use bat as the replacement for cat
      du = "dua"; # Use dua as the replacement for du
      df = "duf"; # Use duf as the replacement for df
      tree = "tre"; # Use tre as the replacement for tree
      clock = "scc"; # Use scc as the replacement for clock
    };
  };

  programs = {
    git = {
      enable = true;

      userName = "${username}";
      userEmail = "${username}@gmail.com";

      delta = {
        enable = true;

        options = {
          features = "decorations";

          true-color = "always";
          whitespace-error-style = "22 reverse";

          line-numbers = true;

          side-by-side = true;
          line-numbers-left-format = "";
          line-numbers-right-format = "| ";

          hyperlinks = true;
          hyperlinks-file-link-format = "vscode://file/{path}:{line}"; # TODO: possible bad code

          merge = {
            conflictstyle = "diff3";
          };

          decorations = {
            commit-decoration-style = "bold yellow box ul";
            file-style = "bold yellow ul";
            file-decoration-style = "none";
            hunk-header-decoration-style = "yellow box";
          };
        };
      };
    };

    git-cliff = {
      enable = true;

      settings = {

      };
    };

    git-credential-oauth.enable = true;

    eza = {
      enable = true;

      enableAliases = true;

      icons = true;
      git = true;
    };

    bat = {
      enable = true;

      extraPackages = with pkgs.bat-extras; [
        batman
      ];
    };

    jq.enable = true;
  };
}
