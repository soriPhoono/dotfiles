{ ... }: {
  import = [
    ./core                # Import the core NixOS modules.

    ./programs/common.nix # Import the common programs.
    ./programs/zsh.nix    # Import the Zsh program.

    ./services            # Import the services.
  ];

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
}
