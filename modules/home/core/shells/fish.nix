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

    workspace = lib.mkOption {
      type = lib.types.package;
      description = "Workspace configuration to enable";

      default = inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
        inherit pkgs;

        module = _: {
          imports = [
            (lib.mkIf
              (builtins.pathExists ../../../../modules/nvim/${config.home.username})
              ../../../../modules/nvim/${config.home.users})
          ];
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;

      shellAliases = {
        v = "${cfg.workspace}/bin/nvim";
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
