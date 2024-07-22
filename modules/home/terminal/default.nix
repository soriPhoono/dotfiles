{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./helix.nix
  ];

  xdg = {
    enable = true;

    userDirs = {
      enable = true;

      createDirectories = true;
    };
  };

  home.shellAliases = with pkgs; {
    cat = "${bat}/bin/bat";

    df = "${duf}/bin/duf";
    du = "${dua}/bin/dua i";
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
          padding = {
            top = 2;
          };
        };

        display = {
          separator = " ➜  ";
        };

        modules = [
          "break"
          "break"
          "break"
          {
            type = "os";
            key = "OS   ";
            keyColor = 31;
          }
          {
            type = "kernel";
            key = " ├  ";
            keyColor = 31;
          }
          {
            type = "shell";
            key = "key": " └  ";
            keyColor = 31;
          }
          "break"
          {
            type = "wm";
            key = "WM   ";
            keyColor = 32;
          }
        ];
      };
    };

    eza = {
      enable = true;
      enableFishIntegration = true;

      extraOptions = [
        "--group-directories-first"
      ];

      git = true;
      icons = true;
    };

    bat.enable = true;
    btop.enable = true;
  };
}
