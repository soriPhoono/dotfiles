{
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];

    optimise = {
      dates = [ "daily" ];
      automatic = true;
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 1d";
    };
  };

  nixpkgs = {
    config.allowUnfree = true;

    overlays = import ../../../overlays;
  };
}
