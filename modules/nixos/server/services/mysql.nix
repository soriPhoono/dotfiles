{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server.mysql;
in {
  options.server.mysql.enable = lib.mkEnableOption "Enable mysql database backend";

  config = lib.mkIf cfg.enable {
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
  };
}
