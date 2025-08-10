{
  lib,
  config,
  ...
}: let
  cfg = config.server.containers.jellyfin;

  nodeName = "media";
in
  with lib; {
    options.server.containers.jellyfin = {
      enable = mkEnableOption "Enable jellyfin media server container";
    };

    config = mkIf cfg.enable {
      virtualisation.oci-containers.containers = {
        jellyfin = {
          image = "jellyfin/jellyfin";

          volumes = [
            "/mnt/config/jellyfin/:/config"
            "/mnt/data/jellyfin/:/cache"
            "/mnt/media/:/media/"
          ];

          networks = [
            "multimedia_network"
          ];

          ports = [
            "8096:8096"
          ];
        };
      };
    };
  }
