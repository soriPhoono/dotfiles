{ lib, pkgs, ... }: {
  imports = [
    ./locale.nix
    ./users.nix

    ./openssh.nix
  ];

  core.cli.enable = true;

  documentation.dev.enable = true;

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    coreutils

    wget
  ];

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
