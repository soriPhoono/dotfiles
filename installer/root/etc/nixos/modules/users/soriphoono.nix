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

  home-manager.users.soriphoono = { pkgs, ... }: {
    home.packages = [
      pkgs.btop
    ]; # List packages installed in the user environment
    # programs.zsh.enable = true; # Enable zsh

    # Version of the state format should match the version of Home Manager.
    # Usually, the same as your NixOS release.
    home.stateVersion = "23.11";
  };
}
