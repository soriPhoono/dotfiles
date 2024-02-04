{ pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Include other system configurations.
    ./modules/boot.nix
    ./modules/cli.nix

    # Include the user configuration(s).
    ./modules/users/soriphoono.nix
  ];

  nix = {
    settings = {
      auto-optimise-store = true; # Automatically optimise the Nix store.
    };
  };

  # Enable automatic updates and set the reboot window.
  system = {
    stateVersion = "23.11"; # NixOS version to use.

    autoUpgrade = {
      enable = true; # Enable automatic upgrades.
      allowReboot = true; # Allow automatic reboots.

      # Reboot window from 3am to 5am.
      rebootWindow = {
        lower = "03:00";
        upper = "05:00";
      };
    };
  };
}
