{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.shells.fish;
in {
  options.core.shells.fish = {
    enable = lib.mkEnableOption "Enable the fish shell";

    shellVariables = lib.mkOption {
      type = with lib.types; attrsOf str;
      description = "Additional environment variables to set in the fish shell";

      default = {};
    };

    shellAliases = lib.mkOption {
      type = with lib.types; attrsOf str;
      description = "Additional aliases to add to the fish shell";

      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      inherit (cfg) shellAliases;

      enable = true;

      shellInitLast = let
        importEnvironment =
          if lib.hasAttr "environment" config.sops.secrets
          then "export (cat ${config.sops.secrets.environment.path})"
          else "";

        shellVariables =
          lib.mapAttrsToList
          (name: value: "set ${name} ${value}")
          cfg.shellVariables;
      in ''
        set fish_greeting

        ${importEnvironment}

        ${lib.concatStringsSep "\n" shellVariables}

        ${pkgs.fastfetch}/bin/fastfetch
      '';
    };
  };
}
