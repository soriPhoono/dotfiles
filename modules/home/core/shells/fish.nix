{
  lib,
  config,
  ...
}: let
  cfg = config.core.shells.fish;
in {
  options.core.shells.fish = {
    enable = lib.mkEnableOption "Enable the fish shell";

    shellInit = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The extra commands to run on a fish login shell";
      example = "fastfetch";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;

      shellInitLast = let
        importEnvironment =
          if lib.hasAttr "environment" config.sops.secrets
          then "export (cat ${config.sops.secrets.environment.path})"
          else "";

        sessionVariables =
          builtins.concatStringsSep
          "\n"
          (lib.mapAttrsToList
            (name: value: "set ${name} \"${value}\"")
            config.core.shells.sessionVariables);

        shellAliases =
          builtins.concatStringsSep
          "\n"
          (lib.mapAttrsToList
            (name: command: "alias ${name}=\"${command}\"")
            config.core.shells.shellAliases);
      in ''
        set fish_greeting

        ${importEnvironment}

        ${sessionVariables}

        ${shellAliases}

        fastfetch
      '';
    };
  };
}
