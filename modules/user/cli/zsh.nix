{ pkgs, ... }: {
  home = {
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
  };

  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableVteIntegration = true;
      historySubstringSearch.enable = true;
      syntaxHighlighting.enable = true;
    };

    zsh.history.extended = true;

    starship = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        add_newline = true; # Add a newline to the prompt
        format = "$directory $character"; # Minimal left prompt
        right_format = "$all"; # Remaining data on right prompt
        command_timeout = 1000; # Set the command timeout to 1000ms

        character = {
          success_symbol = "[➜](bold green)"; # Set the success symbol to a green arrow
          error_symbol = "[✗](bold red)"; # Set the error symbol to a red X
        };

        directory = {
          truncation_length = 8; # Set the truncation length to 8
          truncation_symbol = "…/"; # Set the truncation symbol to an ellipsis
        };

        git_branch = {
          truncation_length = 4; # Set the truncation length to 4
          truncation_symbol = "…"; # Set the truncation symbol to an ellipsis
        };
      };
    };

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
  };
}
