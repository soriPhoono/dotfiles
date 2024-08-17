{ lib, pkgs, ... }: {
  imports = [
    ./locale.nix
    ./users.nix

    ./boot.nix
    ./networkmanager.nix
  ];

  documentation.dev.enable = true;

  security.sudo = {
    execWheelOnly = true;
    wheelNeedsPassword = false;
  };

  environment.systemPackages = with pkgs; [
    coreutils

    wget
  ];

  programs.dconf.enable = true;

  nix = {
    package = pkgs.lix;

    settings = {
      auto-optimise-store = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      builders-use-substitutes = true;

      # extra substituters to add
      extra-substituters = [
        "https://anyrun.cachix.org"
        "https://hyprland.cachix.org"
      ];

      extra-trusted-public-keys = [
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
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
