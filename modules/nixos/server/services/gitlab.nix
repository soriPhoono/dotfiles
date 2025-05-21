{
  lib,
  config,
  ...
}: let
  cfg = config.server.services.gitlab;
in {
  options.server.services.gitlab.enable = lib.mkEnableOption "Enable gitlab on server";

  config = lib.mkIf cfg.enable {
    systemd.services.gitlab-backup.environment.BACKUP = "dump";

    sops.secrets = lib.listToAttrs (map (secret: {
        name = secret;
        value = {
          owner = config.services.gitlab.user;
          group = config.services.gitlab.group;
        };
      }) [
        "gitlab/database_password"
        "gitlab/admin_password"
        "gitlab/secretsKey"
        "gitlab/otpKey"
        "gitlab/variablesKey"
        "gitlab/sessionKey"
        "gitlab/activeRecordSalt"
        "gitlab/activeRecordPrimaryKey"
        "gitlab/activeRecordDeterministicKey"
      ]);

    services = {
      gitlab = {
        enable = true;
        port = 8081;
        statePath = "/mnt/gitlab";
        databasePasswordFile = config.sops.secrets."gitlab/database_password".path;
        initialRootPasswordFile = config.sops.secrets."gitlab/admin_password".path;
        secrets = {
          secretFile = config.sops.secrets."gitlab/secretsKey".path;
          otpFile = config.sops.secrets."gitlab/otpKey".path;
          dbFile = config.sops.secrets."gitlab/variablesKey".path;
          jwsFile = config.sops.secrets."gitlab/sessionKey".path;
          activeRecordSaltFile = config.sops.secrets."gitlab/activeRecordSalt".path;
          activeRecordPrimaryKeyFile = config.sops.secrets."gitlab/activeRecordPrimaryKey".path;
          activeRecordDeterministicKeyFile = config.sops.secrets."gitlab/activeRecordDeterministicKey".path;
        };
      };

      nginx = {
        enable = true;
        recommendedProxySettings = true;
        virtualHosts = {
          localhost = {
            locations."/".proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
          };
        };
      };
    };
  };
}
