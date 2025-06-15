{
  lib,
  config,
  ...
}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = let
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
      ${sessionVariables}

      ${shellAliases}
    '';
  };
}
