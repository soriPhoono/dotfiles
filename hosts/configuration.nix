{ pkgs, user, ... }: {
  imports = [
    ../modules/system # Import the system module (default system configuration)
    ../modules/cli
  ];

  time.timeZone = "America/Chicago"; # Set the time zone to America/Chicago
  i18n.defaultLocale = "en_US.UTF-8"; # Set the default locale to en_US.UTF-8

  console = {
    font = "Lat2-Terminus16"; # Set the console font to Lat2-Terminus16
    keyMap = "us"; # Set the console keymap to us
  };

  networking = {
    networkmanager.enable = true; # Enable NetworkManager.
  };

  environment = {
    systemPackages = with pkgs; [
      tldr # Install community maintained simplified man pages

      coreutils # Install the coreutils package
      killall # Install the killall package for killing processes

      dosfstools # Install the dosfstools package
      exfatprogs # Install the exfatprogs package
      ntfs3g # Install the NTFS-3G driver for windows NTFS partitions

      nix-tree # Install the nix-tree package for viewing the Nix store

      zip # Install the zip package
      unzip # Install the unzip package
      p7zip # Install the p7zip package
      unrar # Install the unrar package

      neofetch # Install the neofetch package

      btop # Install the btop system monitor
      ranger # Install the ranger file manager
      smartmontools # Install the smartmontools package for monitoring hard drives

      curl # Install the curl package
      wget # Install the wget package

      less # Install the less package

      usbutils # Install the usbutils package
      pciutils # Install the pciutils package
    ];
  };

  programs = {
    nano.enable = true; # Enable nano
  };

  users.users."${user}" = {
    password = "password"; # Set the user’s password to ‘password’. Change this using passwd after installation.

    isNormalUser = true; # Set the user as a normal user.

    extraGroups = [
      "wheel"
      "video"
      "audio"
      "networkmanager"
    ]; # Add the user to the wheel, video, audio, and networkmanager groups.

    shell = pkgs.zsh; # Set the user’s shell to zsh.
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

  # Enable automatic updates and set the reboot window.
  system.stateVersion = "23.11"; # NixOS version to use.
}
