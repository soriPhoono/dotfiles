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
    in ''
      ${importEnvironment}
    '';
  };
}
