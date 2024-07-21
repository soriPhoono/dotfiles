{ pkgs, ...}: {
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
          success_symbol = " [➜](bold green) ";
          error_symbol = " [➜](bold red) ";
        };
      };
    };

    fastfetch = {
      enable = true;
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
