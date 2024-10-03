{ pkgs, ... }: {
  imports = [ ./dconf.nix ./git.nix ./eza.nix ./find.nix ./direnv.nix ];

  home = with pkgs; {
    shellAliases = {
      cat = "${bat}/bin/bat";
      df = "${duf}/bin/duf";
      du = "${dua}/bin/dua";
      top = "${btop}/bin/btop";
    };

    packages = with pkgs; [ nh nix-fast-build nix-tree ];
  };

  core.programs = {
    eza.enable = true;
    find.enable = true;
    direnv.enable = true;
  };

  programs = {
    yazi = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
