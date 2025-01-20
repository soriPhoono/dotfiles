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

    ./programs/nix-index.nix
    ./programs/eza.nix
    ./programs/fastfetch.nix
    ./programs/bat.nix
    ./programs/fd.nix
    ./programs/fzf.nix
    ./programs/direnv.nix

    ./programs/git.nix

    ./editors/helix.nix
    ./editors/neovim.nix
  ];

  options.core = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "The username of the user";

      default = "user";
    };

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

    core.programs = lib.mkIf (!cfg.plainShell) {
      nix-index.enable = true;
      eza.enable = true;
      fastfetch.enable = true;
      bat.enable = true;
      fd.enable = true;
      fzf.enable = true;
      direnv.enable = true;
      git.enable = true;
    };

    programs.home-manager.enable = true;

    home = {
      inherit (cfg) username;

      homeDirectory = "/home/${cfg.username}";

      stateVersion = "25.05";
    };
  };
}
