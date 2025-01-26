{
  lib,
  config,
  ...
}: let
  system_key_path = "/etc/ssh/ssh_host_ed25519_key";

  cfg = config.core.secrets;
in {
  options.core.secrets = {
    defaultSopsFile = lib.mkOption {
      type = lib.types.path;
      description = "Default database for import secrets";

      default = ../../../secrets/global.yaml;
    };
  };

  config = {
    services.openssh = {
      enable = true;

      hostKeys = [
        {
          comment = "ed25519 system key for host: ${config.networking.hostName}";

          path = system_key_path;
          rounds = 100;
          type = "ed25519";
        }
      ];
    };

    sops = {
      inherit (cfg) defaultSopsFile;

      age = {
        sshKeyPaths = [
          system_key_path
        ];
      };
    };
  };
}
