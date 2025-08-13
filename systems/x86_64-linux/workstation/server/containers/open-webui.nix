{
  lib,
  config,
  ...
}: let
  cfg = config.server.containers.open-webui;
in
  with lib; {
    options.server.containers.open-webui = {
      enable = mkEnableOption "Enable open-webui ai frontend";
    };

    config = mkIf cfg.enable {
      server.containers = {
        ollama.enable = true;

        searxng.enable = true;
      };

      virtualisation.oci-containers.containers = {
        open-webui = {
          image = "ghcr.io/open-webui/open-webui:main";

          volumes = [
            "/mnt/data/open-webui/:/app/backend/data/"
          ];

          networks = [
            "development_network"
          ];

          ports = [
            "8040:8080"
          ];
        };
      };
    };
  }
