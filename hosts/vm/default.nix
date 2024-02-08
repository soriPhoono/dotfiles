{ pkgs, user, ... }: {
  imports = [
    ./hardware-configuration.nix  # Include the results of the hardware scan.
  ];

  boot = {
    loader.timeout = 3; # Reduce the timeout to 3 seconds.

    kernelPackages = pkgs.linuxKernel.packages.linux_6_7; # Use the 6.7 kernel.
  };

  networking = {
    hostName = "virtual-machine"; # Set the hostname to "virtual-machine".

    networkmanager.enable = true; # Enable NetworkManager.
  };

  users.users."${user}".extraGroups = [
    "wheel" # Add the user to the "wheel" group.
    "networkmanager" # Add the user to the "networkmanager" group.
  ];
}
