{
  lib,
  config,
  ...
}: let
  cfg = config.server.containers.sonarr;
in
  with lib; {
    options.server.containers.sonarr = {
      enable = mkEnableOption "Enable sonarr download manager";
    };

    config = mkIf cfg.enable {
      virtualisation.oci-containers.containers = {
        sonarr = {
          image = "lscr.io/linuxserver/sonarr:latest";

          volumes = [
            "/mnt/config/sonarr:/config"
            "/mnt/media/Shows:/tv"
            "/mnt/media/Torrent:/downloads"
          ];

          networks = [
            "multimedia_network"
          ];

          ports = [
            "8989:8989"
          ];
        };
      };
    };
  }
