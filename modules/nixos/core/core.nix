{ pkgs, vars, ... }: {
  environment.systemPackages = with pkgs; [
    man
    man-pages
    coreutils
    nix-tree

    wget
  ];

  programs.nano.enable = true;

  programs = {
    nano.enable = true;

    firefox.enable = true;
  };

  users = {
    defaultUserShell = pkgs.fish;
    users = {
      root.ignoreShellProgramCheck = true;
      ${vars.defaultUser} = {
        description = "Sori Phoono";

        isNormalUser = true;
        ignoreShellProgramCheck = true;

        extraGroups = [
          "wheel"
          "networkmanager"
          "audio"
          "video"
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
