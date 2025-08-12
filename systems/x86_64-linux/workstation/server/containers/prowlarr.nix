{
  lib,
  config,
  ...
}: let
  cfg = config.server.containers.prowlarr;
in
  with lib; {
    options.server.containers.prowlarr = {
      enable = mkEnableOption "Enable prowlarr download manager";
    };

    config = mkIf cfg.enable {
      virtualisation.oci-containers.containers = {
        prowlarr = {
          image = "lscr.io/linuxserver/prowlarr:latest";

          environment = {
            PUID = "1000";
            PGID = "1000";
          };

          volumes = [
            "/mnt/config/prowlarr:/config"
          ];

          networks = [
            "multimedia_network"
          ];

          ports = [
            "9696:9696"
          ];
        };
      };
    };
  }
