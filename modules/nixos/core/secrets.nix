{config, ...}: let
  system_key_path = "/etc/ssh/ssh_host_ed25519_key";

  cfg = config.core.secrets;
in {
  options.core.secrets = {
    enable = lib.mkEnableOption "Enable secrets management for system specific secrets";
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
      defaultSopsFile =
        if cfg.enable
        then ../../../secrets/${config.core.hostname}/system.yaml
        else ../../../secrets/global.yaml;

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
