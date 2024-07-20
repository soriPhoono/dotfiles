{ lib, pkgs, config, ... }:
let cfg = config.cli;
in {
  options = {
    cli.enable = lib.mkEnableOption "Enable the home CLI module";
  };

  config = lib.mkIf cfg.enable {
    xdg = {
      enable = true;

      userDirs = {
        enable = true;

        createDirectories = true;
      };
    };

    home.shellAliases = with pkgs; {
      ls = "eza";
      ll = "eza -l";
      lt = "eza -T";

      cat = "${bat}/bin/bat";

      df = "${duf}/bin/duf";
      du = "${dua}/bin/dua i";

      btop = "${btop}/bin/btop";
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

      nix-index = {
        enable = true;
      
        enableFishIntegration = true;
      };

      starship = {
        enable = true;
        enableTransience = true;
        enableFishIntegration = true;

        settings = {
          add_newline = true;

          format = "$character";
          right_format = "$all";

          character = {
            success_symbol = " [➜](bold green)";
            error_symbol = " [➜](bold red)";
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

        settings = {
          editor = {
            auto-save = true;

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
    };
  };
}
