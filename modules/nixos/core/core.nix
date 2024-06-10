{ pkgs, vars, ... }: {
  environment.systemPackages = with pkgs; [
    man
    man-pages
    coreutils
    nix-tree

    wget
  ];

  programs = {
    fish.enable = true;
    nano.enable = true;
    firefox.enable = true;
  };

  users = {
    defaultUserShell = pkgs.fish;
    users = {
      ${vars.defaultUser} = {
        description = "Sori Phoono";

        isNormalUser = true;

        extraGroups = [
          "wheel"
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
}
