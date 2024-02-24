{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix

    ./system

    ./system/desktops/gnome.nix
  ];

  networking = {
    hostName = "test";

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.powersave = true;
    };

    firewall = {
      enable = true;

      allowPing = false;
    };
  };

  services.resolved.enable = true;

  console.font = "Lat2-Terminus16";

  environment = {
    variables = {

    };

    systemPackages = with pkgs; [
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
    printing = {
      enable = true;

      # TODO: Add extra options
    };
  };
}
