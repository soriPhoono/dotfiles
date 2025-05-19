{
  lib,
  config,
  ...
}: let
  cfg = config.server.services.postgresql;
in {
  options.server.services.postgresql = {
    enable = lib.mkEnableOption "Enable postgresql database";
  };

  config = lib.mkIf cfg.enable {
    services = {
      postgresql = {
        enable = true;
        dataDir = "/mnt/postgresql";
      };

      postgresqlBackup = {
        enable = true;
        location = "/mnt/backup/postgresql";
        startAt = "*-*-* 23:15:00";
      };
    };
  };
}
