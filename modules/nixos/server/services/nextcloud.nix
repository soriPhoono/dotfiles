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
    sops.secrets.nextcloud_admin_password = {};

    security.acme = {
      acceptTerms = true;
      certs = {
        ${config.services.nextcloud.hostName}.email = "soriphoono@protonmail.com";
      };
    };

    services = {
      nginx.virtualHosts = {
        "${config.services.nextcloud.hostName}" = {
          forceSSL = true;
          enableACME = true;
          listen = [
            {
              addr = "127.0.0.1";
              port = 8080;
            }
          ];
        };
        "localhost" = {
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
              proxy_set_header X-Forwarded-Proto https;
              proxy_pass https://127.0.0.1:8080/;
              proxy_set_header Host $host;
              proxy_cache_bypass $http_upgrade;
              proxy_redirect off;
            '';
          };
        };
      };

      nextcloud = {
        enable = true;

        package = pkgs.nextcloud31;
        hostName = "workstation";
        https = true;
        home = "/mnt/nextcloud";

        database.createLocally = true;

        config = {
          adminpassFile = config.sops.secrets.nextcloud_admin_password.path;
          dbtype = "pgsql";
        };

        settings = let
          prot = "http";
          host = "127.0.0.1";
          dir = "/nextcloud";
        in {
          overwriteprotocol = prot;
          overwritehost = host;
          overwritewebroot = dir;
          overwrite.cli.url = "${prot}://${host}${dir}/";
          htaccess.RewriteBase = dir;
        };
      };
    };
  };
}
