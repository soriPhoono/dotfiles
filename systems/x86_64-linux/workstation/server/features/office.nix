{
  lib,
  config,
  ...
}: let
  cfg = config.server.features.office;
in
  with lib; {
    options.server.features.office = {
      enable = mkEnableOption "Enable office server features";
    };

    config = mkIf cfg.enable {
      server = {
        networks = [
          "office_network"
        ];
        containers = {
          nextcloud.enable = true;
        };
      };

      server.containers.caddy-tailscale.blocks = [
        ''
          https://cloud.${config.server.containers.caddy-tailscale.tn_name} {
            bind tailscale/cloud

            encode zstd gzip

            root * /var/www/html/

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

            php_fastcgi localhost:9000 {
              root /var/www/html/
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
          }
        ''
      ];
    };
  }
