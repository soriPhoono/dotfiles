{
  lib,
  config,
  ...
}: let
  cfg = config.server;

  serviceDir = "/services/jellyfin/";
  dataDir = "/mnt/media";

  endpoint = "https://media.${config.core.networking.tailscale.tn_name}";
in {
  config = lib.mkIf cfg.enable {
    users.groups.multimedia.members = ["nextcloud" config.services.jellyfin.user];

    systemd.tmpfiles.rules = [
      "d ${dataDir} 755 nextcloud multimedia -"
      "d ${dataDir}/Shows/ 755 nextcloud multimedia -"
      "d ${dataDir}/Movies/ 755 nextcloud multimedia -"
      "d ${dataDir}/Music/ 755 nextcloud multimedia -"
    ];

    services = {
      jellyfin = {
        enable = true;

        dataDir = serviceDir;
      };

      caddy.virtualHosts = {
        ${endpoint} = {
          extraConfig = ''
            bind tailscale/media
            reverse_proxy localhost:8096
          '';
        };
      };

      homepage-dashboard.services = [
        {
          "Media" = [
            {
              "JellyFin" = {
                description = "JellyFin media server";
                href = endpoint;
              };
            }
          ];
        }
      ];
    };
  };
}
