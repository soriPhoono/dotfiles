{ lib, pkgs, config, ... }:
let cfg = config.core.shells;
in {
  imports =
    [
      ./dconf.nix
      ./starship.nix
      ./fastfetch.nix
      ./nix-index.nix
      ./git.nix
      ./eza.nix
      ./find.nix
      ./yazi.nix
      ./direnv.nix
    ];

  config = lib.mkIf cfg.enable {
    home.shellAliases = with pkgs; {
      cat = "${bat}/bin/bat";
      df = "${duf}/bin/duf";
      du = "${dua}/bin/dua";
      top = "${btop}/bin/btop";
    };

    core.programs = {
      starship.enable = lib.mkDefault true;
      fastfetch.enable = lib.mkDefault true;
      nix-index.enable = lib.mkDefault true;
      git.enable = lib.mkDefault true;
      eza.enable = lib.mkDefault true;
      find.enable = lib.mkDefault true;
      yazi.enable = lib.mkDefault true;
      direnv.enable = lib.mkDefault true;
    };
  };
}
