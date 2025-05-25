{
  lib,
  config,
  ...
}: let
  cfg = config.core.secrets;
in {
  options.core.secrets = {
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

  config = {
    services.openssh.enable = true;

    sops = {
      inherit (cfg) defaultSopsFile;

      age.sshKeyPaths = map (key: key.path) config.services.openssh.hostKeys;

      secrets = lib.listToAttrs (map (user: {
          name = "users/${user.name}/age_key";

          value = {
            path = "/home/${user.name}/.config/sops/age/keys.txt";
            mode = "0400";
            owner = user.name;
            group = "users";
          };
        })
        config.core.users);
    };

    home-manager.users = lib.listToAttrs (map (user: {
        inherit (user) name;

        value = {
          sops.age.keyFile = config.sops.secrets."users/${user.name}/age_key".path;
        };
      })
      config.core.users);
  };
}
