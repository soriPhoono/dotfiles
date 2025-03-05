{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server.services.nextcloud;
in {
  options.server.services.nextcloud = {
    enable = lib.mkEnableOption "Enable nextcloud natively on the system";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.nextcloud_admin_password = {
      mode = "0440";
      owner = config.users.users.nextcloud.name;
      inherit (config.users.users.nextcloud) group;
    };

    services = {
      nginx.virtualHosts = {
        "${config.services.nextcloud.hostName}".listen = [
          {
            addr = "127.0.0.1";
            port = 8080;
          }
        ];

        "localhost" = {
          locations."/nextcloud/" = {
            priority = 9999;
            extraConfig = ''
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-NginX-Proxy true;
              proxy_set_header X-Forwarded-Proto http;
              proxy_pass http://127.0.0.1:8080/; # tailing / is important!
              proxy_set_header Host $host;
              proxy_cache_bypass $http_upgrade;
              proxy_redirect off;
            '';
          };
        };
      };

      nextcloud = {
        enable = true;
        package = pkgs.nextcloud30;
        hostName = "nextcloud";
        config = {
          dbtype = "sqlite";
          adminpassFile = config.sops.secrets.nextcloud_admin_password.path;
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

    core.boot.impermanence.directories = [
      "/var/lib/nextcloud"
    ];
  };
}
