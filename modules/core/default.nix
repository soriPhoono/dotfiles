{ lib, pkgs, ... }: {
  imports = [
    ./boot.nix
    ./locale.nix
  ];

  documentation.dev.enable = true;

  security = {
    sudo.wheelNeedsPassword = false;
  };

  programs.fish.enable = true;

  networking = {
    networkmanager = {
      enable = true;

      wifi = {
        powersave = false;
      };
    };
  };

  users = {
    defaultUserShell = pkgs.fish;

    users = {
      soriphoono = {
        description = "Sori Phoono";

        isNormalUser = true;

        extraGroups = [
          "wheel"
          "networkmanager"
        ];
      };
    };
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
