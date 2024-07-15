{ inputs, pkgs, ... }: let
  opacity = 0.8;

  default_font = 14;
  focus_font = 16;
  terminal_font = 16;
in {
  stylix = {
    enable = true;

    targets = {
      nixvim.transparent_bg = {
        main = true;
        sign_column = true;
      };
    };

    image = ../../../assets/wallpapers/2.jpg;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    polarity = "dark";

    cursor = {
      package = pkgs.catppuccin-cursors.mochaTeal;
      size = 24;
      name = "Catppuccin-Mocha-Teal-Cursors";
    };

    opacity = {
      applications = opacity;
      desktop = opacity;
      popups = opacity;
      terminal = opacity;
    };

    fonts = {
      serif = {
        package = pkgs.nerdfonts;
        name = "AurulentSansM Nerd Font Propo";
      };

      sansSerif = {
        package = pkgs.nerdfonts;
        name = "AurulentSansM Nerd Font Propo";
      };

      monospace = {
        package = pkgs.nerdfonts;
        name = "JetBrainsMono Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = focus_font;
        desktop = default_font;
        popups = default_font;
        terminal = terminal_font;
      };
    };
  };

  home = {
    shellAliases = with pkgs; {
      ls = "eza";
      ll = "eza -l";
      lt = "eza -T";

      cat = "${bat}/bin/bat";

      df = "${duf}/bin/duf";
      du = "${dua}/bin/dua i";

      btop = "${btop}/bin/btop";
    };

    stateVersion = "24.11";
  };

  xdg = {
    enable = true;

    userDirs = {
      enable = true;

      createDirectories = true;
    };
  };

  programs = {
    git = {
      enable = true;

      userName = "soriphoono";
      userEmail = "soriphoono@gmail.com";

      includes = [
        # TODO: setup sops-nix to store school git data
      ];

      extraConfig = {
        init.defaultBranch = "main";
        url."git@github.com/" = { insteadOf = [ "gh:" "github:" ]; };
        pull.rebase = false;
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

    fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting

        fastfetch
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

    fastfetch = {
      enable = true;
    };

    eza = {
      enable = true;

      extraOptions = [
        "--group-directories-first"
        "--hyperlink"
      ];

      git = true;
      icons = true;
    };

    bat.enable = true;

    helix = {
      enable = true;
      defaultEditor = true;

      ignores = [

      ];

      settings = {
        editor = {
          auto-save = true;

          bufferline = "multiple";

          statusline = {
            left = [
              "mode"
              "version-control"
              "file-base-name"
              "file-modification-indicator"
            ];
            right = [ "diagnostics" "file-type" "position-percentage" ];

            mode = {
              normal = "󰋜";
              insert = "󰏪";
              select = "󰍉";
            };
          };

          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
        };
      };
    };

    home-manager.enable = true;
  };
}
