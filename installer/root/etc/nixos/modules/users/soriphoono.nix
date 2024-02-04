{ pkgs, ... }: {
  imports = [
    <home-manager/nixos>
  ];

  users.users.soriphoono = {
    name = "soriphoono"; # User name
    description = "Sori Phoono"; # Full name
    password = "password"; # Initial password

    isNormalUser = true; # Create a user account

    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user
      "networkmanager" # Enable ‘networkmanager’ for the user
    ];
  };
}
