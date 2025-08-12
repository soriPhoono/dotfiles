{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server.containers.deluge;

  nodeName = "torrent";
in
  with lib; {
    options.server.containers.deluge = {
      enable = mkEnableOption "Enable deluge download daemon";
    };

    config = mkIf cfg.enable {
      virtualisation.oci-containers.containers = {
        deluge = {
          image = "lscr.io/linuxserver/deluge:latest";

          environment = {
            PUID = "1000";
            PGID = "1000";
          };

          volumes = [
            "/mnt/config/deluge:/config"
            "/mnt/media/Torrent:/downloads"
          ];

          networks = [
            "multimedia_network"
          ];

          ports = [
            "8112:8112"
            "6881:6881"
            "6881:6881/udp"
          ];
        };
      };
    };
  }
