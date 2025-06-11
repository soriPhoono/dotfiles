{
  lib,
  pkgs,
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

    systemd.services = {
      "serve_homepage" = {
        description = "Serve system homepage for network navigation";

        after = ["network-pre.target" "homepage-dashboard.service" "tailscaled.service"];
        wants = ["network-pre.target" "homepage-dashboard.service" "tailscaled.service"];
        wantedBy = ["multi-user.target"];

        serviceConfig.type = "oneshot";

        script = with pkgs;
        # bash
          ''
            sleep 1

            ${tailscale}/bin/tailscale serve reset
            ${tailscale}/bin/tailscale serve http://localhost:${builtins.toString config.services.homepage-dashboard.listenPort}
          '';
      };
    };
  };
}
