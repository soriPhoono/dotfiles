{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server;
in {
  config = lib.mkIf cfg.enable {
    sops.secrets = builtins.listToAttrs (map (secret: {
        name = secret;
        value = {
          inherit (config.services.gitlab) group;
          owner = config.services.gitlab.user;
        };
      }) [
        "gitlab/database_password"
        "gitlab/root_password"
        "gitlab/secrets_key"
        "gitlab/db_key"
        "gitlab/otp_key"
        "gitlab/salt_key"
        "gitlab/primary_record_key"
        "gitlab/deterministic_record_key"
      ]);

    services = {
      gitlab = {
        enable = true;

        # Check this with reverse proxy config, could break unix socket
        https = true;
        host = "localhost";
        port = "8086";

        databasePasswordFile = config.sops.secrets."gitlab/database_password".path;
        initialRootPasswordFile = config.sops.secrets."gitlab/root_password".path;
        secrets = {
          secretFile = config.sops.secrets."gitlab/secrets_key".path;
          dbFile = config.sops.secrets."gitlab/db_key".path;
          otpFile = config.sops.secrets."gitlab/otp_key".path;
          jwsFile = pkgs.runCommand "oidcKeyBase" {} "${pkgs.openssl}/bin/openssl genrsa 2048 > $out";
          activeRecordSaltFile = config.sops.secrets."gitlab/salt_key".path;
          activeRecordPrimaryKeyFile = config.sops.secrets."gitlab/primary_record_key".path;
          activeRecordDeterministicKeyFile = config.sops.secrets."gitlab/deterministic_record_key".path;
        };
      };

      caddy.virtualHosts = {
        "gitlab.xerus-augmented.ts.net" = {
          extraConfig = ''
            bind tailscale/gitlab
            reverse_proxy unix//run/gitlab/gitlab-workhorse.socket
          '';
        };
      };
    };

    systemd.services.gitlab-backup.environment.BACKUP = "dump";
  };
}
