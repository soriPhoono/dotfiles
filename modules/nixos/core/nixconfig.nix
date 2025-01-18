# Sane default allowing for user level overriding
{
  inputs,
  lib,
  pkgs,
  ...
}:
with lib.soriphoono; {
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
}
