{
  imports = [
    ./boot.nix
    ./locale.nix
  ];

  documentation = {
    man.mandoc.enable = true;

    dev.enable = true;
  };

  security = {
    rtkit.enable = true;

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
    package = pkgs.nix;

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
