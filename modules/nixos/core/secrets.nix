{
  lib,
  config,
  ...
}: let
  cfg = config.core.secrets;

  system_key_path = "/etc/ssh/ssh_host_ed25519_key";
in {
  options.core.secrets = {
    defaultSopsFile = lib.mkOption {
      type = lib.types.path;
      description = "The default SOPS file to use for system secrets.";
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

        keyFile = "/var/lib/sops-nix/key.txt";
        generateKey = true;
      };
    };
  };
}
