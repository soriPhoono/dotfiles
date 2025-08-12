{
  lib,
  config,
  ...
}: let
  cfg = config.server.containers.lidarr;
in
  with lib; {
    options.server.containers.lidarr = {
      enable = mkEnableOption "Enable lidarr download manager";
    };

    config = mkIf cfg.enable {
      virtualisation.oci-containers.containers = {
        lidarr = {
          image = "blampe/lidarr:latest";

          environment = {
            PUID = "1000";
            PGID = "1000";
          };

          volumes = [
            "/mnt/config/lidarr:/config"
            "/mnt/media/Music:/music"
            "/mnt/media/Torrent:/downloads"
          ];

          networks = [
            "multimedia_network"
          ];

          ports = [
            "8686:8686"
          ];
        };
      };
    };
  }
