{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server.mysql;

  dataDir = "/services/database";
in {
  options.server.mysql.enable = lib.mkEnableOption "Enable mysql database backend";

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
