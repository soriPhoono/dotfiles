{
  lib,
  config,
  ...
}: let
  cfg = config.core.secrets;

  system_key_path = "/etc/ssh/ssh_host_ed25519_key";
in {
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
      defaultSopsFile = ../../../secrets/${config.core.hostname}/system.yaml;

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
