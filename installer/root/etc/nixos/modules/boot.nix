{ pkgs, ... }: {
  # Use the systemd-boot bootloader.
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_6_7;

    loader = {
      timeout = 3; # Reduce the timeout to 3 seconds

      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true; # This is the default, but let's be explicit
        consoleMode = "max"; # Enable more detailed output
      };

    };

    plymouth = {
      # TODO: reenable plymouth once the login manager is set up
      # enable = true;
      # themePackages = [ pkgs.catppuccin-plymouth ];
      # theme = "catppuccin-mocha";
    };

    tmp = {
      useTmpfs = true; # Use a tmpfs for /tmp
      tmpfsSize = "50%"; # 50% of RAM, increase this if nix builds start to fail due to lack of space
      cleanOnBoot = true; # Clean /tmp on boot
    };
  };

  zramSwap.enable = true; # Enable zram swap
}
