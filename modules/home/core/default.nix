{
  lib,
  config,
  ...
}: let
  cfg = config.core;
in {
  imports = [
    ./nixconfig.nix
    ./secrets.nix

    ./shells/bash.nix
    ./shells/fish.nix
    ./shells/starship.nix

    ./programs/eza.nix
    ./programs/fastfetch.nix
    ./programs/bat.nix
    ./programs/ripgrep.nix
    ./programs/fd.nix
    ./programs/fzf.nix
    ./programs/direnv.nix

    ./programs/git.nix
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

    snowfallorg.user.enable = true;

    core.programs = lib.mkIf (!cfg.plainShell) {
      eza.enable = true;
      fastfetch.enable = true;
      bat.enable = true;
      ripgrep.enable = true;
      fd.enable = true;
      fzf.enable = true;
      direnv.enable = true;

      git.enable = true;
    };

    programs.home-manager.enable = true;

    home.stateVersion = "25.05";
  };
}
