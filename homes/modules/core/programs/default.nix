{ pkgs, ... }: {
  imports = [ ./dconf.nix ./git.nix ./eza.nix ./find.nix ./direnv.nix ];

  home = with pkgs; {
    shellAliases = {
      cat = "${bat}/bin/bat";
      df = "${duf}/bin/duf";
      du = "${dua}/bin/dua";
      top = "${btop}/bin/btop";
    };
  };

  core.programs = {
    eza.enable = true;
    find.enable = true;
    yazi.enable = true;
    direnv.enable = true;
  };
}
