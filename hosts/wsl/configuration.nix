{ pkgs, vars, ... }: {
  environment.systemPackages = with pkgs; [
    man
    man-pages
    nix-tree
    
    wget
  ];

  programs = {
    fish.enable = true;

    nano.enable = true;

    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };

    git = {
      enable = true;
      config.init.defaultBranch = "main";
    };
  };

  users.defaultUserShell = pkgs.fish;

  nix = {
    package = pkgs.nix;

    settings = {
      auto-optimise-store = true;
    };

    optimise = {
      dates = [
        "daily"
      ];
      automatic = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
}