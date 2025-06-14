{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server.cloud;

  dataDir = "/services/nextcloud/";
  storageDir = "/mnt/cloud";
in {
  options.server.cloud.enable = lib.mkEnableOption "Enable cloud server services";

  config = lib.mkIf cfg.enable {
    server = {
      mysql.enable = true;
      redis.enable = true;
      mailserver.enable = true;
    };

    sops.secrets =
      lib.genAttrs [
        "server/nextcloud/admin_password"
        "server/nextcloud/nc-token"
      ] (_: {
        owner = "nextcloud";
        group = "nextcloud";
      });

    users.extraGroups = {
      nextcloud.extraGroups = ["redis" "restic"];
      ${config.services.caddy.user}.extraGroups = ["nextcloud"];
    };

    systemd = {
      tmpfiles.rules = [
        "d ${dataDir} 0770 nextcloud nextcloud -"
        "d ${storageDir} 0770 nextcloud nextcloud -"
        "d ${storageDir}/config 0770 nextcloud nextcloud -"
      ];

      services =
        lib.genAttrs [
          "nextcloud-setup"
          "nextcloud-cron"
        ] (_: {
          requires = [
            "mysql.service"
            "redis.service"
          ];
          after = [
            "mysql.service"
            "redis.service"
          ];
        });
    };

    services = {
      mysql = {
        settings.mysqld.innodb_read_only_compressed = 0;
        ensureDatabases = [
          "nextcloud"
        ];
        ensureUsers = [
          {
            name = "nextcloud";
            ensurePermissions = {
              "nextcloud.*" = "ALL PRIVILEGES";
            };
          }
        ];
      };

      nextcloud = {
        enable = true;
        package = pkgs.nextcloud31;

        https = true;
        hostName = "localhost";
        maxUploadSize = "5G";

        home = dataDir;
        datadir = storageDir;

        configureRedis = true;
        database.createLocally = true;

        extraApps = {
          inherit
            (config.services.nextcloud.package.packages.apps)
            news
            contacts
            calendar
            tasks
            notes
            ;
        };
        extraAppsEnable = true;

        config = {
          adminpassFile = config.sops.secrets."server/nextcloud/admin_password".path;
          dbtype = "mysql";
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

          enabledPreviewProviders = [
            "OC\\Preview\\BMP"
            "OC\\Preview\\GIF"
            "OC\\Preview\\JPEG"
            "OC\\Preview\\Krita"
            "OC\\Preview\\MarkDown"
            "OC\\Preview\\MP3"
            "OC\\Preview\\OpenDocument"
            "OC\\Preview\\PNG"
            "OC\\Preview\\TXT"
            "OC\\Preview\\XBitmap"
            "OC\\Preview\\HEIC"
          ];
        };
      };

      phpfpm.pools.nextcloud.settings = {
        "listen.owner" = config.services.caddy.user;
        "listen.group" = config.services.caddy.group;
      };

      nginx.enable = lib.mkForce false;

      caddy.virtualHosts = {
        "https://cloud.${config.core.networking.tailscale.tn_name}" = {
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
          Office = [
            {
              "Nextcloud" = {
                description = "Nextcloud workspace drive";
                href = "https://cloud.${config.core.networking.tailscale.tn_name}";
                icon = "sh-nextcloud";
              };
            }
          ];
        }
      ];
    };
  };
}
