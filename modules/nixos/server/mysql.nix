{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server;

  dataDir = "/services/database";
in {
  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d ${dataDir} 750 ${config.services.mysql.user} ${config.services.mysql.group} -"
    ];

    services.mysql = {
      inherit dataDir;

      enable = true;
      package = pkgs.mariadb;
    };
  };
}
