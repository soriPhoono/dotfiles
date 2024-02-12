{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      tldr # Install community maintained simplified man pages.

      coreutils # Install the coreutils package.
      killall # Install the killall package for killing processes.

      dosfstools # Install the dosfstools package.
      exfatprogs # Install the exfatprogs package.
      ntfs3g # Install the NTFS-3G driver for windows NTFS partitions.

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
    nano.enable = true; # Enable nano text editor.

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
}
