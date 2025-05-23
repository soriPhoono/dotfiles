{
  lib,
  config,
  ...
}: let
  cfg = config.server;
in {
  config = lib.mkIf cfg.enable {
    users.groups.multimedia.members = [config.services.jellyfin.user];

    systemd.tmpfiles.rules = [
      "d /mnt/media/Shows/ 0770 ${config.services.jellyfin.user} multimedia -"
      "d /mnt/media/Movies/ 0770 ${config.services.jellyfin.user} multimedia -"
      "d /mnt/media/Music/ 0770 ${config.services.jellyfin.user} multimedia -"
    ];

    services = {
      jellyfin = {
        enable = true;

        dataDir = "/services/jellyfin";
      };

      caddy.virtualHosts = {
        "jellyfin.xerus-augmented.ts.net" = {
          extraConfig = ''
            bind tailscale/jellyfin
            reverse_proxy localhost:8096
          '';
        };
      };
    };
  };
}
