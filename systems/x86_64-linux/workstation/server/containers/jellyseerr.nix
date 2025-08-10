{
  lib,
  config,
  ...
}: let
  cfg = config.server.containers.jellyseerr;
in
  with lib; {
    options.server.containers.jellyseerr = {
      enable = mkEnableOption "Enable jellyseerr download manager";
    };

    config = mkIf cfg.enable {
      virtualisation.oci-containers.containers = {
        jellyseerr = {
          image = "fallenbagel/jellyseerr";

          volumes = [
            "/mnt/config/jellyseerr:/app/config"
          ];

          networks = [
            "multimedia_network"
          ];

          ports = [
            "5055:5055"
          ];
        };
      };
    };
  }
