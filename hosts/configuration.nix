{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix  # Include the results of the hardware scan.
  ];

  time.timeZone = "America/Chicago"; # Set the time zone to America/Chicago
  i18n.defaultLocale = "en_US.UTF-8"; # Set the default locale to en_US.UTF-8

  console = {
    font = "Lat2-Terminus16"; # Set the console font to Lat2-Terminus16
    keyMap = "us"; # Set the console keymap to us
  };

  nix = {
    settings = {
      auto-optimise-store = true; # Automatically optimise the Nix store.
    };

    gc = {
      automatic = true; # Enable automatic garbage collection.
      dates = "weekly"; # Run garbage collection weekly.
      options = "--delete-older-than 2d"; # Delete generations older than 30 days.
    };

    # package = pkgs.nixFlakes; # Use the new Nix flakes system.
    # registry.nixpkgs.flake = inputs.nixpkgs; # Use the Nixpkgs flake registry.
    # extraOptions = ''
    #   experimental-features = nix-command flakes
    #   keep-outputs = true
    #   keep-derivations = true
    # '';
  };
  nixpkgs.config.allowUnfree = true; # Allow unfree packages.

  environment = {
    systemPackages = with pkgs; [
      tldr # Install community maintained simplified man pages

      coreutils # Install the coreutils package
      killall # Install the killall package

      dosfstools # Install the dosfstools package
      exfatprogs # Install the exfatprogs package
      ntfs3g # Install the NTFS-3G driver for windows NTFS partitions

      nix-tree # Install the nix-tree package

      xdg-user-dirs # Install the xdg-user-dirs package
      xdg-utils # Install the xdg-utils package

      zip # Install the zip package
      unzip # Install the unzip package
      p7zip # Install the p7zip package
      unrar # Install the unrar package

      neofetch # Install the neofetch package

      btop # Install the btop system monitor
      ranger # Install the ranger file manager
      smartmontools # Install the smartmontools package

      curl # Install the curl package
      wget # Install the wget package

      less # Install the less package

      usbutils # Install the usbutils package
      pciutils # Install the pciutils package

      eza # Install the eza ls replacement
      bat # Install the bat cat replacement
      dua # Install the dua disk usage analyzer
      duf # Install the duf disk usage finder
      tre-command # Install the tre command
      scc # Install the scc command
      jq # Install the jq package
    ];
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

      shellAliases = {
        ls = "eza"; # Use eza as the replacement for ls
        cat = "bat"; # Use bat as the replacement for cat
        du = "dua"; # Use dua as the replacement for du
        df = "duf"; # Use duf as the replacement for df
        tree = "tre"; # Use tre as the replacement for tree
        clock = "scc"; # Use scc as the replacement for clock
      };
    };

    starship = {
      enable = true; # Enable starship

      settings = {
        add_newline = true; # Add a newline to the prompt
        format = "$directory $character"; # Minimal left prompt
        right_format = "$all"; # Remaining data on right prompt
        command_timeout = 1000; # Set the command timeout to 1000ms

        character = {
          success_symbol = "[➜](bold green)"; # Set the success symbol to a green arrow
          error_symbol = "[✗](bold red)"; # Set the error symbol to a red X
        };

        directory = {
          truncation_length = 8; # Set the truncation length to 8
          truncation_symbol = "…/"; # Set the truncation symbol to an ellipsis
        };

        git_branch = {
          truncation_length = 4; # Set the truncation length to 4
          truncation_symbol = "…"; # Set the truncation symbol to an ellipsis
        };
      };
    };

    nano.enable = true; # Enable nano
    neovim = {
      enable = true; # Enable neovim
      defaultEditor = true; # Set neovim as the default editor
    };

    git = {
      enable = true; # Enable git

      config = {
        init = {
          defaultBranch = "main"; # Use ‘main’ as the default branch
        };
        user = {
          name = "soriphoono";
          email = "soriphoono@gmail.com";
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

  users = {
    users.soriphoono = {
      description = "Sori Phoono"; # Set the user’s description to "Sori Phoono" for /etc/passwd.
      password = "password"; # Set the user’s password to ‘password’.

      isNormalUser = true; # Set the user as a normal user.

      extraGroups = [
        "wheel"
        "video"
        "audio"
        "networkmanager"
      ]; # Add the user to the wheel, video, audio, and networkmanager groups.

      shell = pkgs.zsh; # Set the user’s shell to zsh.
    };
  };

  # Enable automatic updates and set the reboot window.
  system = {
    autoUpgrade = {
      allowReboot = true;

      rebootWindow = {
        lower = "03:00"; # Set the lower reboot window to 03:00.
        upper = "05:00"; # Set the upper reboot window to 05:00.
      };
    };

    stateVersion = "23.11"; # NixOS version to use.
  };
}
