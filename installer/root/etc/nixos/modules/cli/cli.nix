{ pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan
    ./networking.nix
  ];

  time.timeZone = "America/Chicago"; # Set the time zone to America/Chicago
  i18n.defaultLocale = "en_US.UTF-8"; # Set the default locale to en_US.UTF-8

  console = {
    font = "Lat2-Terminus16"; # Set the console font to Lat2-Terminus16
    keyMap = "us"; # Set the console keymap to us
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
    man
    man-pages # Install the man pages core package
    texinfo # Install the texinfo package

    ntfs3g # Install the NTFS-3G driver for windows NTFS partitions

    nano # Install the nano text editor
    neovim # Install the neovim text editor
  ];

  users = {
    defaultUserShell = pkgs.zsh; # Set the default shell to zsh
  };
}
