{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.networking.homepage;
in {
  options.core.networking.homepage = {
    enable = lib.mkEnableOption "Enable homepage for system";
  };

  config = lib.mkIf cfg.enable {
    services.homepage-dashboard = {
      enable = true;
      allowedHosts = "${config.networking.hostName}.${config.core.networking.tailscale.tn_name}";

      settings = {
        title = config.networking.hostName;
        background = {
          image = "https://i.ibb.co/B2N7M7c2/image.png";
          blur = "xs";
          opacity = 75;
        };
        cardBlur = "md";
        bookmarksStyle = "icons";
        headerStyle = "boxed";
      };

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
    };

    systemd.services = {
      serve-homepage = {
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
