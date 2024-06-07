{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      tldr

      # For disk/volume management
      dua
      duf

      # For viewing file systems
      scc
    ];
  };

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

        du = "dua i";
        df = "duf";

        clock = "scc";
        cat = "bat";
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

    fastfetch = {
      # TODO: configure fastfetch

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

    yazi = {
      enable = true;

      enableFishIntegration = true;
    };

    bat.enable = true;
    fzf.enable = true;
    jq.enable = true;
  };
}