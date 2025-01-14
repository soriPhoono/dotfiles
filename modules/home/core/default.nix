{ lib, config, ... }:
let
  cfg = config.core;
in
{
  imports = [
    ./bash.nix
    ./fish.nix

    ./starship.nix
    ./nix-index.nix
    ./eza.nix
    ./fastfetch.nix
    ./bat.nix
    ./fd.nix
    ./fzf.nix
    ./direnv.nix

    ./git.nix
  ];

  options.core = {
    plainShell = lib.mkOption {
      type = lib.types.bool;
      description = "Disable cli tools";

      default = false;
    };
  };

  config = {
    xdg = {
      enable = true;

      userDirs = {
        enable = true;

        createDirectories = true;
      };
    };

    core = lib.mkIf (!cfg.plainShell) {
      nix-index.enable = true;
      eza.enable = true;
      fastfetch.enable = true;
      bat.enable = true;
      fd.enable = true;
      fzf.enable = true;
      direnv.enable = true;
    };

    programs.home-manager.enable = true;

    home.stateVersion = "25.05";
  };
}
