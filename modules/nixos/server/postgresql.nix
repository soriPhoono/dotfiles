{
  lib,
  config,
  ...
}: let
  cfg = config.server;
in {
  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d /services/postgresql 0750 postgres postgres -"
    ];

    services = {
      postgresql = {
        enable = true;
        dataDir = "/services/postgresql";
      };

      postgresqlBackup = {
        enable = true;
        location = "/mnt/backup/postgresql";
        startAt = "*-*-* 23:15:00";
      };
    };
  };
}
