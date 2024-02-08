{ pkgs, user, ... }: {
  imports = [
    ../modules # Import the system module (default system configuration).
  ];

  time.timeZone = "America/Chicago"; # Set the time zone to America/Chicago.
  i18n.defaultLocale = "en_US.UTF-8"; # Set the default locale to en_US.UTF-8.

  console.font = "Lat2-Terminus16"; # Set the console font to Lat2-Terminus16.

  # NOTE: Change user password using passwd after installation.
  users = {
    defaultUserShell = pkgs.zsh;

    users."${user}" = {
      password = "password"; # Set the user’s password to ‘password’.

      isNormalUser = true; # Set the user as a normal user.
    };
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

  system.stateVersion = "23.11"; # NixOS version to use.
}
