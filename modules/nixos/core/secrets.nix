{
  inputs,
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.core.secrets;
in {
  options.${namespace}.core.secrets = {
    enable = lib.mkEnableOption "Enable secrets management";

    defaultSopsFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = ''
        The default secrets file to use for the secrets module.
        This is used when no specific secrets file is provided.
      '';
      example = ./secrets.yaml;
    };
  };

  config = lib.mkIf cfg.enable {
    services.openssh.enable = true;

    sops = {
      inherit (cfg) defaultSopsFile;

      age = {
        keyFile = "/tmp/admin.key";
        sshKeyPaths = map (key: key.path) config.services.openssh.hostKeys;
      };
    };
  };
}
