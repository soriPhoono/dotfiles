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

    ];

    programs = {
      git = {
        enable = true; # Enable git

        config = {
          user = {
            name = "soriphoono"; # Git user name
            email = "soriphoono@gmail.com"; # Git user email
          };
          init = {
            defaultBranch = "main"; # Use ‘main’ as the default branch
          };
          url = {
            "https://github.com/" = {
              insteadOf = [
                "gh:" # Use ‘gh:’ as a prefix for GitHub URLs
                "github:" # Use ‘github:’ as a prefix for GitHub URLs
              ];
            };
          };
        };
      };
    };

    home.stateVersion = "23.11"; # Version of the state format
  };
}
