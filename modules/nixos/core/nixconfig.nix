# Sane default allowing for user level overriding
{pkgs, ...}: {
  nix = {
    package = pkgs.nixVersions.latest;

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
