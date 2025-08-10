{
  lib,
  config,
  ...
}: let
  cfg = config.server.features.multimedia;
in
  with lib; {
    options.server.features.multimedia = {
      enable = mkEnableOption "Enable multimedia server";
    };

    config = mkIf cfg.enable {
      server = {
        networks = [
          "multimedia_network"
        ];
        containers = {
          deluge.enable = true;

          prowlarr.enable = true;
          sonarr.enable = true;
          radarr.enable = true;
          lidarr.enable = true;
          readarr.enable = true;

          jellyfin.enable = true;
          jellyseerr.enable = true;
        };
      };

      server.containers.caddy-tailscale.blocks = [
        ''
          https://torrent.${config.server.containers.caddy-tailscale.tn_name} {
            bind tailscale/torrent
            reverse_proxy localhost:8112
          }

          https://pvr.${config.server.containers.caddy-tailscale.tn_name} {
            bind tailscale/pvr

            redir /index /index/
            redir /shows /shows/
            redir /movies /movies/
            redir /music /music/
            redir /books /books/

            reverse_proxy /index/* localhost:9696
            reverse_proxy /shows/* localhost:8989
            reverse_proxy /movies/* localhost:7878
            reverse_proxy /music/* localhost:8686
            reverse_proxy /books/* localhost:8787
            reverse_proxy localhost:5055
          }

          https://media.${config.server.containers.caddy-tailscale.tn_name} {
            bind tailscale/media
            reverse_proxy localhost:8096
          }
        ''
      ];
    };
  }
