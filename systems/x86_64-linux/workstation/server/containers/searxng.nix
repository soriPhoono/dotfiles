{
  lib,
  config,
  ...
}: let
  cfg = config.server.containers.searxng;
in
  with lib; {
    options.server.containers.searxng = {
      enable = mkEnableOption "Enable searxng llm execution";
    };

    config = mkIf cfg.enable {
      virtualisation.oci-containers.containers = {
        searxng = {
          image = "searxng/searxng:latest";

          environment = {
            SEARXNG_HOSTNAME = "chat.xerus-augmented.ts.net";
          };

          volumes = [
            "/mnt/config/searxng/:/etc/searxng"
            "/mnt/data/searxng/:/var/cache/searxng/"
          ];

          networks = [
            "development_network"
          ];

          ports = [
            "8888:8080"
          ];
        };
      };
    };
  }
