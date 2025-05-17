{
  lib,
  config,
  ...
}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = let
      importEnvironment =
        if lib.hasAttr "environment" config.sops.secrets
        then "export (cat ${config.sops.secrets.environment.path})"
        else "";

      sessionVariables =
        builtins.concatStringsSep
        "\n"
        (lib.mapAttrsToList
          (name: value: "export ${name}=\"${value}\"")
          config.core.shells.sessionVariables);

      shellAliases =
        builtins.concatStringsSep
        "\n"
        (lib.mapAttrsToList
          (name: command: "alias ${name}=\"${command}\"")
          config.core.shells.shellAliases);
    in ''
      ${importEnvironment}

      ${sessionVariables}

      ${shellAliases}
    '';
  };
}
