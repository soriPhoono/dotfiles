{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server.containers.nextcloud;

  nodeName = "cloud";
in
  with lib; {
    options.server.containers.nextcloud = {
      enable = mkEnableOption "Enable nextcloud service container";
    };

    config = mkIf cfg.enable {
      sops = {
        secrets."server/nextcloud/admin_password" = {};
        templates."nextcloud.env".content = ''
          MYSQL_HOST=mariadb
          MYSQL_DATABASE=nextcloud
          MYSQL_USER=nextcloud
          MYSQL_PASSWORD=${config.sops.placeholder."server/mariadb/users/nextcloud_password"}

          REDIS_HOST=redis

          NEXTCLOUD_ADMIN_USER=admin
          NEXTCLOUD_ADMIN_PASSWORD=${config.sops.placeholder."server/nextcloud/admin_password"}
          NEXTCLOUD_TRUSTED_DOMAINS=cloud.xerus-augmented.ts.net
          OVERWRITEPROTOCOL=https
        '';
      };

      server.containers = {
        redis.enable = true;
        mariadb = {
          enable = true;
          users = {
            nextcloud = "nextcloud";
          };
        };
      };

      virtualisation.oci-containers.containers = {
        nextcloud = {
          image = "nextcloud:fpm";

          environmentFiles = [
            config.sops.templates."nextcloud.env".path
          ];

          volumes = [
            "/mnt/cloud/:/var/www/html/"
          ];

          networks = [
            "office_network"
          ];

          ports = [
            "9000:9000"
          ];
        };
      };
    };
  }
