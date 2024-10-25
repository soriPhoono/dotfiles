{ lib, pkgs, config, ... }:
let cfg = config.core.shells;
in {
  imports = [
    ./starship.nix
    ./fastfetch.nix
    ./nix-index.nix
    ./ripgrep.nix
    ./git.nix
    ./eza.nix
    ./find.nix
    ./direnv.nix
  ];

  options = {
    core.shells.enable = lib.mkEnableOption "Enable shell integration";
  };

  config = lib.mkIf cfg.enable {
    home = {
      shellAliases = with pkgs; {
        cat = "${bat}/bin/bat";
        df = "${duf}/bin/duf";
        du = "${dua}/bin/dua";
        v = "${nvim-pkg}/bin/nvim";
      };

      packages = with pkgs; [
        btop
        nvtopPackages.full
      ];
    };

    core.programs = {
      starship.enable = lib.mkDefault true;
      fastfetch.enable = lib.mkDefault true;
      nix-index.enable = lib.mkDefault true;
      git.enable = lib.mkDefault true;
      eza.enable = lib.mkDefault true;
      find.enable = lib.mkDefault true;
      direnv.enable = lib.mkDefault true;
    };
  };
}
