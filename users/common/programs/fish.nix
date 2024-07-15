{ pkgs, ... }: {
  home.shellAliases = with pkgs; {
    ls = "eza";
    ll = "eza -l";
    lt = "eza -T";

    cat = "${bat}/bin/bat";

    df = "${duf}/bin/duf";
    du = "${dua}/bin/dua i";
  };

  programs = {
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
  };
}
