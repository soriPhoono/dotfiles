{
  lib,
  config,
  ...
}: let
  cfg = config.core.boot.secrets;
in {
  options.core.boot.secrets.defaultSopsFile = lib.mkOption {
    type = lib.types.path;
    description = "The path to the vault file";
  };

  config = {
      services.openssh.enable = true;

      sops = {
        inherit (cfg) defaultSopsFile;

        age = {
          sshKeyPaths = map (key: key.path) config.services.openssh.hostKeys;
        };
      };
    };
}
