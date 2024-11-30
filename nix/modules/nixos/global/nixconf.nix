{
  nix = {
    settings.experimental-features = [ "flakes" "nix-command" ];

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
}
