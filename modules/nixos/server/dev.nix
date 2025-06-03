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
        "server/gitlab/database_password"
        "server/gitlab/root_password"
        "server/gitlab/secrets_key"
        "server/gitlab/db_key"
        "server/gitlab/otp_key"
        "server/gitlab/salt_key"
        "server/gitlab/primary_record_key"
        "server/gitlab/deterministic_record_key"
      ]);

    services = {
      gitlab = {
        enable = true;

        # Check this with reverse proxy config, could break unix socket
        https = true;
        host = "localhost";
        port = 8086;

        databasePasswordFile = config.sops.secrets."server/gitlab/database_password".path;
        initialRootPasswordFile = config.sops.secrets."server/gitlab/root_password".path;
        secrets = {
          secretFile = config.sops.secrets."server/gitlab/secrets_key".path;
          dbFile = config.sops.secrets."server/gitlab/db_key".path;
          otpFile = config.sops.secrets."server/gitlab/otp_key".path;
          jwsFile = pkgs.runCommand "oidcKeyBase" {} "${pkgs.openssl}/bin/openssl genrsa 2048 > $out";
          activeRecordSaltFile = config.sops.secrets."server/gitlab/salt_key".path;
          activeRecordPrimaryKeyFile = config.sops.secrets."server/gitlab/primary_record_key".path;
          activeRecordDeterministicKeyFile = config.sops.secrets."server/gitlab/deterministic_record_key".path;
        };
      };

      caddy.virtualHosts = {
        "dev.${config.core.networking.tailscale.tn_name}" = {
          extraConfig = ''
            bind tailscale/dev
            reverse_proxy ${config.services.gitlab.host}:${config.services.gitlab.port}
          '';
        };
      };

      homepage-dashboard.services = [
        {
          "Development" = [
            {
              "GitLab" = {
                description = "Personal gitlab instance for development automation on homelab";
                href = "https://dev.${config.core.networking.tailscale.tn_name}";
              };
            }
          ];
        }
      ];
    };

    systemd.services.gitlab-backup.environment.BACKUP = "dump";
  };
}
