{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    tmp = {
      useTmpfs = true;
      tmpfsSize = "50%"; # 50% of RAM
      cleanOnBoot = true;
    };
  };

  zramSwap.enable = true;

  hardware = {
    pulseaudio.enable = false;
  };

  security = {
    rtkit.enable = true;
  };

  networking = {
    hostName = "test";

    networkmanager.enable = true;

    firewall = {
      enable = true;

      allowPing = false;
    };
  };

  time.timeZone = "America/Chicago";

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  console.font = "Lat2-Terminus16";

  environment = {
    variables = {

    };

    systemPackages = [
      config.boot.kernelPackages.cpupower

      tldr # Install community maintained simplified man pages.

      coreutils # Install the coreutils package.
      killall # Install the killall package for killing processes.

      dosfstools # Install the dosfstools package.
      exfatprogs # Install the exfatprogs package.
      ntfs3g # Install the NTFS-3G driver for windows NTFS partitions.
      apfs-fuse # Install the apfs-fuse package for reading APFS partitions.
      hfsprogs # Install the hfsprogs package for reading HFS partitions.

      nix-tree # Install the nix-tree package for viewing the Nix store.

      zip # Install the zip package.
      unzip # Install the unzip package.
      p7zip # Install the p7zip package.
      unrar # Install the unrar package.

      neofetch # Install the neofetch package.

      curl # Install the curl package.
      wget # Install the wget package.

      less # Install the less package.

      usbutils # Install the usbutils package.
      pciutils # Install the pciutils package.

      btop # Install the btop system monitor.
      ranger # Install the ranger file manager.
      smartmontools # Install the smartmontools package for monitoring hard drives.
    ];
  };

  programs = {
    less.enable = true;

    zsh = {
      enable = true;

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

  services = {
    xserver = {
      enable = true;

      layout = "us";
      xkbVariant = "";

      displayManager = {
        gdm.enable = true;
      };

      desktopManager = {
        gnome.enable = true;
      };
    };

    pipewire = {
      enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse.enable = true;

      jack.enable = true;
    };

    printing = {
      enable = true;

      # TODO: Add extra options
    };
  };

  users.users.soriphoono = {
    isNormalUser = true;
    description = "Sori Phoono";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;

    packages = with pkgs; [
      firefox
    ];
  };

  sound.enable = true;


  nix = {
    settings = {
      auto-optimise-store = true; # Automatically optimise the Nix store.

      # TODO: Will reactivate later
      # experimental-features = [ "nix-command" "flakes" ]; # Enable experimental features.
    };

    gc = {
      automatic = true; # Enable automatic garbage collection.
      dates = "weekly"; # Run garbage collection weekly.
      options = "--delete-older-than 2d"; # Delete generations older than 30 days.
    };
  };
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11";
}
