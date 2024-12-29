{ nixosConfig, ... }: {
  imports = [
    ./bash.nix
    ./fish.nix

    ./eza.nix
    ./fastfetch.nix
    ./git.nix
    ./starship.nix
  ];

  xdg = {
    enable = true;

    userDirs = {
      enable = true;

      createDirectories = true;
    };
  };

  programs = {
    bash = {
      enable = true;
      historyControl = [ "erasedups" "ignoreboth" ];
    };

    direnv = {
      enable = true;

      nix-direnv.enable = true;
    };

    nix-index = {
      enable = true;

      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    fd = {
      enable = true;
      hidden = true;

      extraOptions = [
        "--follow"
        "--color=always"
      ];

      ignores = [
        ".git"
        "*.bak"
      ];
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;

      defaultCommand = "fd --type file";
      defaultOptions = [
        "--ansi"
      ];
    };

    zellij = {
      enable = true;

      settings = {
        ui = {
          pane_frames = {
            rounded_corners = true;
            hide_session_name = true;
          };
        };
      };
    };

    ripgrep.enable = true;

    home-manager.enable = true;
  };

  home.stateVersion = nixosConfig.system.stateVersion;
}
