{ config, pkgs, ... }: {
  imports = [
    ./core
  ];

  nix = {
    settings = {
      auto-optimise-store = true; # Automatically optimise the Nix store.

      # TODO: Will reactivate later
      # experimental-features = [ "nix-command" "flakes" ]; # Enable experimental features.
    };

    gc = {
      automatic = true; # Enable automatic garbage collection.
      dates = "weekly"; # Run garbage collection weekly.
      options = "--delete-older-than 2d"; # Delete generations older than 30 days.
    };
  };
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11";
}
