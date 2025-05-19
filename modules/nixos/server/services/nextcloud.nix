{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server.services.nextcloud;
in {
  options.server.services.nextcloud = {
    enable = lib.mkEnableOption "Enable nextcloud backend services";
  };

  config = lib.mkIf cfg.enable {
    server.services.postgresql.enable = true;

    sops.secrets.nextcloud_admin_password = {};

    systemd = {
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
            ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
          }
        ];
      };

      postgresqlBackup.databases = [
        "nextcloud"
      ];

      redis.servers.nextcloud = {
        enable = true;
        port = 31638;
        bind = "localhost";
      };

      nextcloud = {
        enable = true;

        https = true;
        package = pkgs.nextcloud31;
        hostName = "nextcloud";
        home = "/mnt/nextcloud";

        database.createLocally = true;

        caching.redis = true;

        autoUpdateApps.enable = true;

        config = {
          adminpassFile = config.sops.secrets.nextcloud_admin_password.path;
          dbtype = "pgsql";
        };

        settings = let
          prot = "https";
          host = "workstation.xerus-augmented.ts.net";
          dir = "/nextcloud";
        in {
          overwriteprotocol = prot;
          overwritehost = host;
          overwritewebroot = dir;
          overwrite.cli.url = "${prot}://${host}${dir}/";
          htaccess.RewriteBase = dir;
        };

        extraOptions = {
          redis = {
            host = "localhost";
            port = 31638;
            dbindex = 0;
            timeout = 1.5;
          };
        };
      };

      nginx = {
        enable = true;
        recommendedGzipSettings = true;
        recommendedOptimization = true;
        recommendedProxySettings = true;
        recommendedTslSettings = true;

        virtualHosts = {
          "${config.services.nextcloud.hostName}" = {
            forceSSL = true;

            listen = [
              {
                addr = "127.0.0.1";
                port = 8080;
              }
            ];
          };
          "workstation.xerus-augmented.ts.net" = {
            forceSSL = true;

            locations = {
              "^~ /.well-known" = {
                priority = 9000;
                extraConfig = ''
                  absolute_redirect off;
                  location ~ ^/\\.well-known/(?:carddav|caldav)$ {
                    return 301 /nextcloud/remote.php/dav;
                  }
                  location ~ ^/\\.well-known/host-meta(?:\\.json)?$ {
                    return 301 /nextcloud/public.php?service=host-meta-json;
                  }
                  location ~ ^/\\.well-known/(?!acme-challenge|pki-validation) {
                    return 301 /nextcloud/index.php$request_uri;
                  }
                  try_files $uri $uri/ =404;
                '';
              };
              "/nextcloud/" = {
                priority = 9999;
                extraConfig = ''
                  proxy_set_header X-Real-IP $remote_addr;
                  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                  proxy_set_header X-NginX-Proxy true;
                  proxy_set_header X-Forwarded-Proto http;
                  proxy_pass https://localhost:8080/;
                  proxy_set_header Host $host;
                  proxy_cache_bypass $http_upgrade;
                  proxy_redirect off;
                '';
              };
            };
          };
        };
      };
    };
  };
}
