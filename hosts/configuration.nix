{ lib, inputs, pkgs, config, ... }: {
  imports = [
    ./vm/hardware-configuration.nix

    inputs.hyprland.nixosModules.default
  ];

  documentation.dev.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest; # Use the 6.7 kernel. TODO: this should target linux 6.7. fix if otherwise.

    loader = {
      timeout = 3;

      efi.canTouchEfiVariables = true; # Allow the bootloader to modify EFI variables.

      systemd-boot = {
        enable = true; # This is the default, but let's be explicit.
        consoleMode = "max"; # Enable more detailed output.
      };
    };

    tmp = {
      useTmpfs = true; # Use a tmpfs for /tmp.
      tmpfsSize = "50%"; # 50% of RAM, increase this if nix builds start to fail due to lack of space.
      cleanOnBoot = true; # Clean /tmp on boot.
    };
  };

  zramSwap.enable = true; # Enable zram swap.

  time.timeZone = lib.mkDefault "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8"; # Set the default locale to en_US.UTF-8.

  console.font = lib.mkDefault "Lat2-Terminus16"; # Set the console font to Lat2-Terminus16.

  environment = {
    variables.NIXOS_OZONE_WL = "1";

    systemPackages = with pkgs; [
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

  networking = {
    hostName = "virtual-machine"; # Set the hostname to "virtual-machine".

    networkmanager = {
      enable = true;
    };

    firewall = {
      enable = true; # Enable the firewall.

      allowPing = false; # Disable ping requests.
    };
  };

  xdg = {
    portal = {
      enable = true;

      xdgOpenUsePortal = true;

      config = {
        common = {
          default = [
            "gtk"
          ];
        };
        hyprland = {
          default = [
            "hyprland"
          ];
        };
      };

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };

  programs = {
    nano.enable = true; # Enable nano text editor.

    less.enable = true;

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

    hyprland.enable = true;
  };

  users.users.soriphoono = {
    password = "password"; # Set the user’s password to ‘password’.

    isNormalUser = true; # Set the user as a normal user.

    shell = pkgs.zsh; # Set the user’s shell to Zsh.

    extraGroups = [
      "wheel" # Add the user to the "wheel" group.
      "networkmanager" # Add the user to the "networkmanager" group.
    ];
  };

  nix = {
    settings = {
      auto-optimise-store = true; # Automatically optimise the Nix store.

      experimental-features = [ "nix-command" "flakes" ]; # Enable experimental features.
    };

    gc = {
      automatic = true; # Enable automatic garbage collection.
      dates = "weekly"; # Run garbage collection weekly.
      options = "--delete-older-than 2d"; # Delete generations older than 30 days.
    };
  };

  system.stateVersion = lib.mkDefault "23.11";
}
