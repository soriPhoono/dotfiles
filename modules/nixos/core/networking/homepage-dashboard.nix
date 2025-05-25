{
  lib,
  config,
  ...
}: let
  cfg = config.core.networking.tailscale;
in {
  config = lib.mkIf cfg.enable {
    services.homepage-dashboard = {
      enable = true;
      allowedHosts = "${config.networking.hostName}.${cfg.tn_name}";
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
  };
}
