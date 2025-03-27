{ config, pkgs, ... }: {
  imports = [
    ./nixconf.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "soriphoono";
  home.homeDirectory = "/home/soriphoono";

  # Session variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    fish = {
      enable = true;

      shellInitLast = ''
        set fish_greeting

        ${pkgs.fastfetch}/bin/fastfetch
      '';
    };

    starship = {
      enable = true;

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

    direnv = {
      enable = true;

      nix-direnv.enable = true;
    };

    eza = {
      enable = true;

      git = true;
      icons = "auto";

      extraOptions = [
        "--group-directories-first"
      ];
    };

    fastfetch = {
      enable = true;

      settings = {
        logo = {
          source = ./assets/logo.txt;
          color = {"1" = "cyan";};

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

    git = {
      enable = true;

      userName = "soriphoono";
      userEmail = "soriphoono@gmail.com";

      ignores = [
        "*.bak"
      ];

      extraConfig = {
        init.defaultBranch = "main";

        diff.algorithm = "histogram";

        help.autocorrect = "prompt";

        commit.verbose = true;

        push = {
          default = "current";
          autoSetupRemote = true;
        };
        
        pull.rebase = true;
        
        rebase.autosquash = true;

        rerere.enabled = true;

        merge.conflictStyle = "zdiff3";

        url = {
          "git@github.com:" = {
            insteadOf = "github:";
          };
        };
      };

      delta = {
        enable = true;

        options = {
          line-numbers = true;
          side-by-side = true;
        };
      };
    };

    home-manager.enable = true;
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
