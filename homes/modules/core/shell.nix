{ pkgs, ... }: {
  home.shellAliases = with pkgs; {
    find = "fd";
    cat = "bat";
    df = "${duf}/bin/duf";
    du = "${dua}/bin/dua";
  };

  programs = {
    nix-index = {
      enable = true;

      enableFishIntegration = true;
    };

    fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting

        direnv hook fish | source

        fastfetch
      '';
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
          success_symbol = "[➜](bold green) ";
          error_symbol = "[➜](bold red) ";
        };
      };
    };

    fastfetch = {
      enable = true;

      settings = {
        logo = {
          source = ../../../assets/ascii/fastfetch.txt;
          color = { "1" = "cyan"; };

          padding = { right = 1; };
        };

        display = {
          size = { binaryPrefix = "si"; };

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
      enableFishIntegration = true;

      extraOptions = [ "--group-directories-first" ];

      git = true;
      icons = true;
    };

    fd = {
      enable = true;
      hidden = true;

      extraOptions = [ "--follow" "--color=always" ];

      ignores = [ ".git" "*.bak" ];
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;

      defaultCommand = "fd --type file";
      defaultOptions = [ "--ansi" ];
    };

    bat.enable = true;

    direnv = {
      enable = true;

      nix-direnv.enable = true;
    };
  };
}
