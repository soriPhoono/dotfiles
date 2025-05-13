{
  lib,
  config,
  ...
}: let
  cfg = config.core.secrets;
in {
  options.core.secrets = {
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

      age.sshKeyPaths = map (key: key.path) config.services.openssh.hostKeys;
    };

    home-manager.users = lib.listToAttrs (map (user: {
        inherit (user) name;

        value = {
          sops.age.sshKeyPaths = map (key: key.path) config.services.openssh.hostKeys;
        };
      })
      config.core.users);
  };
}
