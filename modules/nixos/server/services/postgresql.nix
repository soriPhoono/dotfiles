{
  lib,
  config,
  ...
}: let
  cfg = config.server.psql;

  dataDir = "/services/database/postgresql";
in {
  options.server.psql.enable = lib.mkEnableOption "Enable postgresql database";

  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d ${dataDir} 750 postgres postgres -"
    ];

    services.postgresql = {
      inherit dataDir;

      enable = true;
    };
  };
}
