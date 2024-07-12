{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = [
      
    ];
  };

  nix = {
    settings = {
      auto-optimise-store = true;

      experimental-features = [ "nix-command" "flakes" ];

      keep-derivations= true;
      keep-outputs = true;
    };

    optimise = {
      dates = [ "daily" ];
      automatic = true;
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 2d";
    };
  };
}
