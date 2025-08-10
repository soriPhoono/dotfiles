{
  lib,
  config,
  ...
}: let
  cfg = config.server.containers.redis;
in
  with lib; {
    options.server.containers.redis = {
      enable = mkEnableOption "Enable jellyfin media server container";
    };

    config = mkIf cfg.enable {
      virtualisation.oci-containers.containers = {
        redis = {
          image = "redis";

          volumes = [
            "/mnt/data/redis:/data"
          ];

          networks = [
            "office_network"
          ];
        };
      };
    };
  }
