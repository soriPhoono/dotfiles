{
  lib,
  config,
  ...
}: let
  cfg = config.server.containers.radarr;
in
  with lib; {
    options.server.containers.radarr = {
      enable = mkEnableOption "Enable radarr download manager";
    };

    config = mkIf cfg.enable {
      virtualisation.oci-containers.containers = {
        radarr = {
          image = "lscr.io/linuxserver/radarr:latest";

          environment = {
            PUID = "1000";
            PGID = "1000";
          };

          volumes = [
            "/mnt/config/radarr:/config"
            "/mnt/media/Movies:/movies"
            "/mnt/media/Torrent:/downloads"
          ];

          networks = [
            "multimedia_network"
          ];

          ports = [
            "7878:7878"
          ];
        };
      };
    };
  }
