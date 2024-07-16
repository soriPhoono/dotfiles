{ lib, pkgs, ... }: {
  imports = [
    ./locale.nix
    ./users.nix

    ./openssh.nix
  ];

  environment.systemPackages = with pkgs; [
    coreutils

    wget
  ];

  programs = {
    fish.enable = true;

    dconf.enable = true;

    nix-index-database.comma.enable = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    optimise = {
      dates = [
        "daily"
      ];
      automatic = true;
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 2d";
    };
  };

  system.stateVersion = lib.mkDefault "24.11";
}
