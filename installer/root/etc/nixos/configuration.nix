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
      auto-optimise-store = true;
    };
  };

  # Enable automatic updates and set the reboot window.
  system = {
    stateVersion = "23.11";

    autoUpgrade = {
      enable = true;
      allowReboot = true;
      rebootWindow = {
        lower = "03:00";
        upper = "05:00";
      };
    };
  };
}
