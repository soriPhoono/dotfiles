{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server.services.nextcloud;
in {
  imports = [
    "${fetchTarball {
      url = "https://github.com/onny/nixos-nextcloud-testumgebung/archive/fa6f062830b4bc3cedb9694c1dbf01d5fdf775ac.tar.gz";
      sha256 = "0gzd0276b8da3ykapgqks2zhsqdv4jjvbv97dsxg0hgrhb74z0fs";
    }}/nextcloud-extras.nix"
  ];

  options.server.services.nextcloud = {
    enable = lib.mkEnableOption "Enable nextcloud backend services";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets =
      (lib.listToAttrs (map (user: {
          name = "nextcloud/${user.name}_password";
          value = {
          };
        })
        config.core.users))
      // {
        "nextcloud/admin_password" = {};
      };

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
        enable = true;
        dataDir = "/mnt/postgresql";
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

      postgresqlBackup = {
        enable = true;
        location = "/mnt/backup/postgresql";
        startAt = "*-*-* 23:15:00";
        databases = [
          "nextcloud"
        ];
      };

      nextcloud = {
        enable = true;

        https = true;
        package = pkgs.nextcloud31;
        hostName = "nextcloud";
        home = "/mnt/nextcloud";

        configureRedis = true;

        database.createLocally = true;

        extraApps = {
          inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
        };
        extraAppsEnable = true;

        ensureUsers = lib.listToAttrs (map (user: {
            inherit (user) name;
            value = {
              email = user.email;
              passwordFile = config.sops.secrets."nextcloud/${user.name}_password".path;
            };
          })
          config.core.users);

        config = {
          adminpassFile = config.sops.secrets."nextcloud/admin_password".path;
          dbtype = "pgsql";
        };

        phpOptions = {
          "opcache.interned_strings_buffer" = 16;
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
          default_phone_region = "US";
          trusted_proxies = [
            "127.0.0.1"
          ];
          maintenance_window_start = "1";
        };
      };

      nginx = {
        enable = true;
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;

        virtualHosts = {
          "${config.services.nextcloud.hostName}" = {
            listen = [
              {
                addr = "localhost";
                port = 8080;
              }
            ];
          };
          "workstation.xerus-augmented.ts.net" = {
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
                  proxy_pass http://localhost:8080/;
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
