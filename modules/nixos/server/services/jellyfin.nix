{
  lib,
  config,
  ...
}: let
  cfg = config.server.services.jellyfin;
in {
  options.server.services.jellyfin.enable = lib.mkEnableOption "Enable Jellyfin server";

  config = lib.mkIf cfg.enable {
    services = {
      jellyfin = {
        enable = true;

        openFirewall = true;

        dataDir = "/mnt/jellyfin/";
      };

      nginx = {
        enable = true;
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;

        virtualHosts = {
          "workstation.xerus-augmented.ts.net" = {
            locations = {
              "/jellyfin/" = {
                priority = 9999;
                extraConfig = ''
                  proxy_set_header X-Real-IP $remote_addr;
                  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                  proxy_set_header X-NginX-Proxy true;
                  proxy_set_header X-Forwarded-Proto https;
                  proxy_pass http://localhost:8096/;
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
