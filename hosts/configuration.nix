{ lib, inputs, pkgs, config, ... }: {
  imports = [
    ./vm/hardware-configuration.nix

    # inputs.lanzaboote.nixosModules.lanzaboote
  ];

  documentation.dev.enable = true;

  boot = {
    bootspec.enable = true; # TODO: this could be a nonexistant paramenter.

    kernelPackages = pkgs.linuxPackages_latest; # Use the 6.7 kernel. TODO: this should target linux 6.7. fix if otherwise.

    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

    initrd = {
      systemd.enable = true; # Enable systemd in the initrd.
      supportedFilesystems = [ "ext4" ]; # Add support for ext4 and btrfs.
    };

    loader = {
      timeout = 3;

      efi.canTouchEfiVariables = true; # Allow the bootloader to modify EFI variables.

      systemd-boot = {
        enable = true; # This is the default, but let's be explicit.
        consoleMode = "max"; # Enable more detailed output.
      };
    };

    consoleLogLevel = 3; # Set the console log level to 3.

    # plymouth.enable = true; # Enable Plymouth.

    tmp = {
      useTmpfs = true; # Use a tmpfs for /tmp.
      tmpfsSize = "50%"; # 50% of RAM, increase this if nix builds start to fail due to lack of space.
      cleanOnBoot = true; # Clean /tmp on boot.
    };
  };

  zramSwap.enable = true; # Enable zram swap.

  time.timeZone = lib.mkDefault "America/Chicago";

  i18n = {
    defaultLocale = "en_US.UTF-8"; # Set the default locale to en_US.UTF-8.

    supportedLocales = [
      # TODO: Add your supported locales here.
    ];
  };

  console.font = lib.mkDefault "Lat2-Terminus16"; # Set the console font to Lat2-Terminus16.

  environment = {
    systemPackages = with pkgs; [
      config.boot.kernelPackages.cpupower
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
