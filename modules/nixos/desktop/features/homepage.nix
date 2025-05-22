{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.features.homepage;
in {
  options.desktop.features.homepage = {
    enable = lib.mkEnableOption "Enable homepage for server services browsing";
  };

  config = lib.mkIf cfg.enable {
    services = {
      homepage-dashboard = {
        enable = true;
        allowedHosts = "${config.networking.hostName}.${config.core.networking.tailscale.tn_name}";

        widgets = [
          {
            resources = {
              cpu = true;
              cputemp = true;
              disk = "/";
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

      caddy = {
        enable = true;
        virtualHosts = {
          "${config.networking.hostName}.${config.server.ts_name}" = {
            extraConfig = ''
              reverse_proxy localhost:${config.services.homepage-dashboard.listenPort} {

              }
            '';
          };
        };
      };
    };
  };
}
