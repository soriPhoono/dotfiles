{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core;
in {
  imports = [
    ./secrets.nix

    ./shells/bash.nix
    ./shells/fish.nix
    ./shells/starship.nix

    ./programs/fastfetch.nix
    ./programs/fd.nix
    ./programs/fzf.nix

    ./programs/git.nix
  ];

  options.core = {
    plainShell = lib.mkEnableOption "Enable plain shell configuration";
  };

  config = {
    home.packages = with pkgs; [
      zip
      unzip

      unrar
    ];

    xdg = {
      enable = true;

      userDirs = {
        enable = true;

        createDirectories = true;
      };
    };

    snowfallorg.user.enable = true;

    core.programs = lib.mkIf (!cfg.plainShell) {
      fastfetch.enable = true;
      fd.enable = true;
      fzf.enable = true;

      git.enable = true;
    };

    programs = {
      bat.enable = true;
      eza = {
        enable = true;

        enableFishIntegration = config.core.shells.fish.enable;

        git = true;
        icons = "auto";

        extraOptions = [
          "--group-directories-first"
        ];
      };
      ripgrep.enable = true;

      direnv = {
        enable = true;

        nix-direnv.enable = true;
      };

      btop.enable = true;

      home-manager.enable = true;
    };

    home.stateVersion = "25.05";
  };
}
