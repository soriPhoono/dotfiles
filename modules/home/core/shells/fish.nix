{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.shells.fish;
in {
  options.core.shells.fish = {
    enable = lib.mkEnableOption "Enable the fish shell";
  };

  config = lib.mkIf cfg.enable {
    stylix.targets = {
      neovim.enable = false;
      nixvim.enable = false;
    };

    programs.fish = {
      enable = true;

      shellAliases = {
        trash = "${pkgs.glib}/bin/gio trash";

        v =
          lib.mkIf (builtins.pathExists ../../../../modules/nvim/${config.home.username})
          "${inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvim (import ../../../../modules/nvim/${config.home.username})}/bin/nvim";
      };

      shellInitLast = let
        importEnvironment =
          if lib.hasAttr "environment" config.sops.secrets
          then "export (cat ${config.sops.secrets.environment.path})"
          else "";
      in ''
        set fish_greeting

        ${importEnvironment}

        ${pkgs.fastfetch}/bin/fastfetch
      '';
    };
  };
}
