{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server.containers.qbittorrent;
in
  with lib; {
    options.server.containers.qbittorrent = {
      enable = mkEnableOption "Enable qbittorrent download daemon";
    };

    config = mkIf cfg.enable {
      virtualisation.oci-containers.containers = {
        qbittorrent = {
          image = "lscr.io/linuxserver/qbittorrent:latest";

          environment = {
            PUID = "1000";
            PGID = "1000";
          };

          volumes = [
            "/mnt/config/qbittorrent:/config"
            "/mnt/media/Torrent:/downloads"
          ];

          networks = [
            "multimedia_network"
          ];

          ports = [
            "8112:8080"
            "6881:6881"
            "6881:6881/udp"
          ];
        };
      };
    };
  }
