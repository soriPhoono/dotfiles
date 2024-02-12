{ username, ... }: {
  imports = [
    ./hardware-configuration.nix  # Include the results of the hardware scan.

    ../../modules/boot/uefi.nix   # Include the UEFI boot loader.
    ../../modules/desktop         # Include the desktop environment.
    ../../modules/development     # Include the development environment.
  ];

  networking = {
    hostName = "virtual-machine"; # Set the hostname to "virtual-machine".

    firewall = {
      enable = true; # Enable the firewall.

      allowPing = false; # Disable ping requests.
    };

    networkmanager.enable = true; # Enable NetworkManager.
  };

  users.users."${username}".extraGroups = [
    "wheel" # Add the user to the "wheel" group.
    "networkmanager" # Add the user to the "networkmanager" group.
  ];
}
