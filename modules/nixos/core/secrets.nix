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

      secrets =
        lib.genAttrs
        (map (name: "users/${name}/age_key") (builtins.attrNames config.core.users))
        (name: {
          path = "/home/${name}/.config/sops/age/keys.txt";
          mode = "0400";
          owner = builtins.elemAt (lib.splitString "/" name) 1;
          group = "users";
        });
    };

    home-manager.users =
      builtins.mapAttrs (name: _: {
        sops.age.keyFile = config.sops.secrets."users/${name}/age_key".path;
      })
      config.core.users;
  };
}
