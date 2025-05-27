{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server;
in {
  config = lib.mkIf cfg.enable {
    sops.secrets = {
      "server/nextcloud/admin_password" = {};
    };

    users.groups = {
      nextcloud.members = ["nextcloud" config.services.caddy.user];
    };

    systemd = {
      tmpfiles.rules = [
        "d /services/nextcloud 0770 nextcloud nextcloud -"
      ];

      services."nextcloud-setup" = {
        requires = [
          "postgresql.service"
        ];
        after = [
          "postgresql.service"
        ];
      };
    };

    services = {
      postgresql = {
        ensureDatabases = [
          "nextcloud"
        ];
        ensureUsers = [
          {
            name = "nextcloud";
            ensureDBOwnership = true;
          }
        ];
      };

      postgresqlBackup.databases = [
        "nextcloud"
      ];

      nextcloud = {
        enable = true;
        package = pkgs.nextcloud31;

        https = true;
        hostName = "localhost";
        maxUploadSize = "5G";

        home = "/services/nextcloud";
        datadir = "/mnt/cloud";

        configureRedis = true;
        database.createLocally = true;

        extraApps = {
          inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
        };
        extraAppsEnable = true;
        autoUpdateApps = {
          enable = true;
          startAt = "01:00:00";
        };

        config = {
          adminpassFile = config.sops.secrets."server/nextcloud/admin_password".path;
          dbtype = "pgsql";
        };

        phpOptions = {
          "opcache.interned_strings_buffer" = 16;
        };

        settings = {
          default_phone_region = "US";

          trusted_domains = [
            "cloud.${config.core.networking.tailscale.tn_name}"
          ];

          trusted_proxies = [
            "127.0.0.1"
          ];

          log_type = "file";
          maintenance_window_start = "1";

          mail_smtpmode = "sendmail";
          mail_sendmailmode = "pipe";
        };
      };

      phpfpm.pools.nextcloud.settings = {
        "listen.owner" = config.services.caddy.user;
        "listen.group" = config.services.caddy.group;
      };

      nginx.enable = lib.mkForce false;

      caddy.virtualHosts = {
        "cloud.${config.core.networking.tailscale.tn_name}" = {
          extraConfig = ''
            bind tailscale/cloud

            encode zstd gzip

            root * ${config.services.nginx.virtualHosts.${config.services.nextcloud.hostName}.root}

            redir /.well-known/carddav /remote.php/dav 301
            redir /.well-known/caldav /remote.php/dav 301
            redir /.well-known/* /index.php{uri} 301
            redir /remote/* /remote.php{uri} 301

            header {
              Strict-Transport-Security max-age=31536000
              Permissions-Policy interest-cohort=()
              X-Content-Type-Options nosniff
              X-Frame-Options SAMEORIGIN
              Referrer-Policy no-referrer
              X-XSS-Protection "1; mode=block"
              X-Permitted-Cross-Domain-Policies none
              X-Robots-Tag "noindex, nofollow"
              -X-Powered-By
            }

            php_fastcgi unix/${config.services.phpfpm.pools.nextcloud.socket} {
              root ${config.services.nginx.virtualHosts.${config.services.nextcloud.hostName}.root}
              env front_controller_active true
              env modHeadersAvailable true
            }

            @forbidden {
              path /build/* /tests/* /config/* /lib/* /3rdparty/* /templates/* /data/*
              path /.* /autotest* /occ* /issue* /indie* /db_* /console*
              not path /.well-known/*
            }
            error @forbidden 404

            @immutable {
              path *.css *.js *.mjs *.svg *.gif *.png *.jpg *.ico *.wasm *.tflite
              query v=*
            }
            header @immutable Cache-Control "max-age=15778463, immutable"

            @static {
              path *.css *.js *.mjs *.svg *.gif *.png *.jpg *.ico *.wasm *.tflite
              not query v=*
            }
            header @static Cache-Control "max-age=15778463"

            @woff2 path *.woff2
            header @woff2 Cache-Control "max-age=604800"

            file_server
          '';
        };
      };

      homepage-dashboard.services = [
        {
          "Office" = [
            {
              "Nextcloud" = {
                description = "Nextcloud workspace drive";
                href = "https://cloud.${config.core.networking.tailscale.tn_name}";
              };
            }
          ];
        }
      ];
    };
  };
}
