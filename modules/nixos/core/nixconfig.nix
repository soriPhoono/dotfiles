{
  inputs,
  pkgs,
  ...
}: {
  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];

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
