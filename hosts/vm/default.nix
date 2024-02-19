{ username, ... }: {
  imports = [
    ./hardware-configuration.nix            # Include the results of the hardware scan.

    ../system/networking/networkmanager.nix # Import the NetworkManager configuration.
    ../system/programs/hyprland.nix         # Import the Hyprland configuration.
    ../system/services/location.nix         # Import the location service.
    ../system/services/pipewire.nix         # Import the PipeWire service.
    ../system/services/power.nix            # Import the power management service.
    ../system/services/brightness.nix       # Import the brightness service.
  ];

  networking = {
    hostName = "virtual-machine"; # Set the hostname to "virtual-machine".

    firewall = {
      enable = true; # Enable the firewall.

      allowPing = false; # Disable ping requests.
    };
  };

  users.users."${username}".extraGroups = [
    "networkmanager" # Add the user to the "networkmanager" group.
  ];
}
