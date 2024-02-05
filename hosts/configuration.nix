{ config, lib, pkgs, inputs, vars, ... }:
let
  terminal = pkgs.${vars.terminal}; # Extract the terminal from the variables package.
in
{
  # Use the systemd-boot bootloader.
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_6_7; # Use the 6.7 kernel.

    loader = {
      timeout = 3; # Reduce the timeout to 3 seconds.

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

  time.timeZone = "America/Chicago"; # Set the time zone to America/Chicago
  i18n.defaultLocale = "en_US.UTF-8"; # Set the default locale to en_US.UTF-8

  console = {
    font = "Lat2-Terminus16"; # Set the console font to Lat2-Terminus16
    keyMap = "us"; # Set the console keymap to us
  };

  networking = {
    useDHCP = false; # Disable DHCP
    networkmanager.enable = true; # Enable NetworkManager to manage network connections
  };

  environment = {
    variables = {
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
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
    ];
  };

  programs = {
    dconf.enable = true; # Enable dconf

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
    users.${vars.user} = {
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

  nix = {
    settings = {
      auto-optimise-store = true; # Automatically optimise the Nix store.
    };
    gc = {
      automatic = true; # Enable automatic garbage collection.
      dates = "weekly"; # Run garbage collection weekly.
      options = "--delete-older-than 2d"; # Delete generations older than 30 days.
    };
    package = pkgs.nixFlakes; # Use the new Nix flakes system.
    registry.nixpkgs.flake = inputs.nixpkgs; # Use the Nixpkgs flake registry.
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };
  nixpkgs.config.allowUnfree = true; # Allow unfree packages.

  # Enable automatic updates and set the reboot window.
  system.stateVersion = "23.11"; # NixOS version to use.
}
