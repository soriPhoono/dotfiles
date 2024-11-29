{ pkgs, config, ... }: {
  imports = [ ./bash.nix ./fish.nix ];

  xdg = {
    enable = true;

    userDirs = {
      enable = true;

      createDirectories = true;
    };
  };

  programs = {
    direnv = {
      enable = true;

      nix-direnv.enable = true;
    };

    starship = {
      enable = true;
      enableFishIntegration = config.cli.fish.enable;
      enableTransience = config.cli.fish.enable;

      settings = {
        add_newline = true;

        format = "$character";
        right_format = "$all";

        character = {
          success_symbol = "[➜](bold green) ";
          error_symbol = "[➜](bold red) ";
        };
      };
    };

    fastfetch = {
      enable = true;

      settings = {
        logo = {
          source = ../../../assets/supporting/fastfetch.txt;
          color = { "1" = "cyan"; };

          padding.right = 1;
        };

        display = {
          color = "cyan";
          separator = "  ";
        };

        modules = [
          {
            type = "datetime";
            key = "Date";
            format = "{1}-{3}-{11}";
          }
          {
            type = "datetime";
            key = "Time";
            format = "{14}:{17}:{20}";
          }

          "break"
          "os"
          "wm"
          {
            type = "users";
            key = "User";
            myselfOnly = true;
          }
          {
            type = "cpu";
            key = "CPU";
            temp = true;
          }
          {
            type = "gpu";
            key = "GPU";
            temp = true;
          }
        ];
      };
    };

    eza = {
      enable = true;
      enableFishIntegration = config.cli.fish.enable;

      extraOptions = [ "--group-directories-first" ];

      git = true;
      icons = "auto";
    };

    fd = {
      enable = true;
      hidden = true;

      extraOptions = [ "--follow" "--color=always" ];

      ignores = [ ".git" "*.bak" ];
    };

    fzf = {
      enable = true;
      enableFishIntegration = config.cli.fish.enable;

      defaultCommand = "fd --type file";
      defaultOptions = [ "--ansi" ];
    };

    ripgrep.enable = true;

    git = {
      enable = true;

      userName = "soriphoono";
      userEmail = "soriphoono@gmail.com";

      extraConfig = {
        init.defaultBranch = "main";
        url."git@github.com:" = { insteadOf = [ "gh:" "github:" ]; };
        pull.rebase = true;
      };

      delta = {
        enable = true;

        options = {
          dark = true;
          line-numbers = true;
          side-by-side = true;

          diff.colorMoved = "default";
          merge.conflictstyle = "diff3";
        };
      };
    };

    nix-index = {
      enable = true;

      enableBashIntegration = true;
      enableFishIntegration = config.cli.fish.enable;
    };

    home-manager.enable = true;
  };

  cli.fish.extraShellInit = "${pkgs.fastfetch}/bin/fastfetch";

  home.stateVersion = "24.11";
}
