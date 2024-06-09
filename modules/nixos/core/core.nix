{ pkgs, vars, ... }: {
  environment.systemPackages = with pkgs; [
    man
    man-pages
    nix-tree

    wget
  ];

  programs.nano.enable = true;

  users = {
    defaultUserShell = pkgs.fish;
    users = {
      root.ignoreShellProgramCheck = true;
      ${vars.defaultUser} = {
        isNormalUser = true;
        ignoreShellProgramCheck = true;
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