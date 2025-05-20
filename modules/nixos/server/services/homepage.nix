{
  lib,
  config,
  ...
}: let
  cfg = config.server.services.homepage;
in {
  options.server.services.homepage.enable = lib.mkEnableOption "Enable homepage dashboard";

  config = lib.mkIf cfg.enable {
    services = {
      homepage-dashboard = {
        enable = true;
        openFirewall = true;
        allowedHosts = "workstation.xerus-augmented.ts.net";

        widgets = [
          {
            resources = {
              cpu = true;
              cputemp = true;
              disk = "/mnt";
              memory = true;
              uptime = true;
            };
          }
          {
            search = {
              provider = "duckduckgo";
              target = "_blank";
            };
          }
        ];

        services = [
          {
            "Office" = [
              {
                "Nextcloud" = {
                  description = "Nextcloud workspace drive";
                  href = "https://workstation.xerus-augmented.ts.net/nextcloud/";
                };
              }
            ];
          }
        ];

        bookmarks = [
          {
            Developer = [
              {
                Github = [
                  {
                    abbr = "GH";
                    href = "https://github.com/";
                  }
                ];
              }
            ];
          }
          {
            Entertainment = [
              {
                YouTube = [
                  {
                    abbr = "YT";
                    href = "https://youtube.com/";
                  }
                ];
              }
            ];
          }
        ];
      };

      nginx = {
        enable = true;
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;

        virtualHosts = {
          "workstation.xerus-augmented.ts.net".locations = {
            "/" = {
              priority = 9999;
              extraConfig = ''
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-NginX-Proxy true;
                proxy_set_header X-Forwarded-Proto http;
                proxy_pass http://localhost:8082/;
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
}
