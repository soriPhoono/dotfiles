{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix

    ./system

    ./system/hardware/pipewire.nix

    ./system/desktops/gnome.nix
  ];

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
}
