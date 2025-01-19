{
  lib,
  config,
  ...
}: let
  cfg = config.core;
in {
  imports = [
    ./secrets.nix

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
    username = lib.mkOption {
      type = lib.types.str;
      description = "Set the username";
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

    home = {
      homeDirectory = "/home/${cfg.username}";

      stateVersion = "25.05";
    };
  };
}
