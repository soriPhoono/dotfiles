{
  lib,
  config,
  ...
}: let
  cfg = config.server.containers.navidrome;
in
  with lib; {
    options.server.containers.navidrome = {
      enable = mkEnableOption "Enable navidrome download manager";
    };

    config = mkIf cfg.enable {
      virtualisation.oci-containers.containers = {
        navidrome = {
          image = "deluan/navidrome:latest";

          volumes = [
            "/mnt/data/navidrome:/data"
            "/mnt/media/Music:/music:ro"
          ];

          networks = [
            "multimedia_network"
          ];

          ports = [
            "4533:4533"
          ];
        };
      };
    };
  }
