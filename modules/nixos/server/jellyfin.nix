{
  lib,
  config,
  ...
}: let
  cfg = config.server;
in {
  config = lib.mkIf cfg.enable {
    users.groups.multimedia.members = ["nextcloud" config.services.jellyfin.user];

    systemd.tmpfiles.rules = [
      "d /mnt/media/ 755 nextcloud multimedia -"
      "d /mnt/media/Shows/ 755 nextcloud multimedia -"
      "d /mnt/media/Movies/ 755 nextcloud multimedia -"
      "d /mnt/media/Music/ 755 nextcloud multimedia -"
    ];

    services = {
      jellyfin = {
        enable = true;

        dataDir = "/services/jellyfin";
      };

      caddy.virtualHosts = {
        "media.xerus-augmented.ts.net" = {
          extraConfig = ''
            bind tailscale/media
            reverse_proxy localhost:8096
          '';
        };
      };
    };
  };
}
