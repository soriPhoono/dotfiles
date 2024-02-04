{ pkgs, ... }: {
  networking = {
    hostName = "home_desktop"; # Set the hostname to ‘nixos’

    networkmanager.enable = true; # Enable NetworkManager to manage network connections
  };

  programs = {
    zsh = {
      enable = true; # Enable zsh

      autosuggestions = {
        enable = true; # Enable zsh-autosuggestions
        strategy = [
          "history" # Use history to determine suggestions
          "completion" # Use completion to determine suggestions
          "match_prev_cmd" # Use previous command to determine suggestions
        ];
      };

      syntaxHighlighting = {
        enable = true; # Enable zsh-syntax-highlighting
        highlighters = [
          "main" # Enable main highlighter
          "brackets" # Enable bracket highlighter
          "pattern" # Enable pattern highlighter
          "cursor" # Enable cursor highlighter
          "regexp" # Enable regexp highlighter
          "root" # Enable root highlighter
          "line" # Enable line highlighter
        ];
      };
    };

    git = {
      enable = true; # Enable git

      config = {
        init = {
          defaultBranch = "main"; # Use ‘main’ as the default branch
        };
        url = {
          "https://github.com/" = {
            insteadOf = [
              "gh:" # Use ‘gh:’ as a prefix for GitHub URLs
              "github:" # Use ‘github:’ as a prefix for GitHub URLs
            ];
          };
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    pkgs.man
    pkgs.man-pages # Install the man pages core package
    pkgs.texinfo # Install the texinfo package

    pkgs.ntfs3g # Install the NTFS-3G driver for windows NTFS partitions
  ];

  users = {
    defaultUserShell = pkgs.zsh; # Set the default shell to zsh
  };
}
