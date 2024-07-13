{ pkgs, ... }: {
  home = {
    shellAliases = {
      cat = "bat";

      df = "${pkgs.duf}/bin/duf";
      du = "${pkgs.dua}/bin/dua i";
    };
  };

  programs = {
    fish = {
      enable = true;

      interactiveShellInit =
        # fish
        ''
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
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };

    fastfetch = {
      enable = true;

      settings = {
        logo = {
          type = "file";
          source = ../../../assets/text/cli.logo;
        };
      };
    };

    eza = {
      enable = true;
      enableFishIntegration = true;

      extraOptions = [ "--group-directories-first" "--hyperlink" ];

      git = true;
      icons = true;
    };

    bat.enable = true;
    ripgrep.enable = true;
  };
}
