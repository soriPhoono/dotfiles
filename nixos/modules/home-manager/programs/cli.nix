{ pkgs, ... }: {
  home.packages = with pkgs; [
    dua
    duf
  ];

  programs = {
    fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting

        fastfetch
      '';

      shellAliases = {
        ls = "eza";
        ll = "eza -l";
        lt = "eza -T";

        cat = "bat";

        df = "duf";
        du = "dua i";
      };
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

    fastfetch.enable = true;

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
    ripgrep.enable = true;

    alacritty = {
      enable = true;

      settings = {
        window = {
          opacity = 0.8;


          blur = true;

          decorations = "None";
          startup_mode = "Maximized";
        };

        cursor.style = "Beam";
      };
    };
  };
}
