# Sane default allowing for user level overriding
{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      allowed-users = [
        "@wheel"
      ];

      trusted-users = [
        "@wheel"
      ];
    };

    gc = {
      automatic = true;
      dates = "daily";
      persistent = true;
    };

    optimise = {
      automatic = true;
      persistent = true;
      dates = [
        "daily"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;
}
