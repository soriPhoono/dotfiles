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
        secrets = {
          "server/nextcloud/admin_password" = {};
          "server/nextcloud/jwt_secret" = {};
        };
        templates = {
          "nextcloud-whiteboard-server.env".content = ''
            JWT_SECRET_KEY=${config.sops.placeholder."server/nextcloud/jwt_secret"}
          '';
          "nextcloud.env".content = ''
            POSTGRES_HOST=postgresql
            POSTGRES_DB=nextcloud
            POSTGRES_USER=nextcloud
            POSTGRES_PASSWORD=${config.sops.placeholder."server/postgresql/users/nextcloud_password"}

            REDIS_HOST=redis

            NEXTCLOUD_ADMIN_USER=admin
            NEXTCLOUD_ADMIN_PASSWORD=${config.sops.placeholder."server/nextcloud/admin_password"}
            NEXTCLOUD_TRUSTED_DOMAINS=cloud.xerus-augmented.ts.net
            OVERWRITEPROTOCOL=https
            TRUSTED_PROXIES=127.0.0.1
          '';
        };
      };

      server.containers = {
        redis.enable = true;
        postgresql = {
          enable = true;
          users = {
            nextcloud = "nextcloud";
          };
        };
      };

      virtualisation.oci-containers.containers = {
        nextcloud-whiteboard-server = {
          image = "ghcr.io/nextcloud-releases/whiteboard:stable";

          environmentFiles = [
            config.sops.templates."nextcloud-whiteboard-server.env".path
          ];

          environment = {
            NEXTCLOUD_URL = "https://cloud.xerus-augmented.ts.net";
          };

          networks = [
            "office_network"
          ];

          ports = [
            "3002:3002"
          ];
        };

        nextcloud-cron = {
          image = "nextcloud:fpm";

          entrypoint = "/cron.sh";

          volumes = [
            "/mnt/cloud/:/var/www/html/"
          ];

          networks = [
            "office_network"
          ];
        };

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
