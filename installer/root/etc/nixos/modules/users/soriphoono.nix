{ pkgs, ... }:
let
  user = "soriphoono";
  full_name = "Sori Phoono";
in
{
  users.users.${user} = {
    description = ${full_name}; # Full name
    password = "password"; # Initial password

    isNormalUser = true; # Create a user account

    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user
      "video" # Enable video acceleration for the user
      "audio" # Enable audio for the user
      "networkmanager" # Enable ‘networkmanager’ for the user
    ];
  };
}
