{
  lib,
  config,
  ...
}: let
  cfg = config.server.features.development;
in
  with lib; {
    options.server.features.development = {
      enable = mkEnableOption "Enable development server features";
    };

    config = mkIf cfg.enable {
      server = {
        networks = [
          "development_network"
        ];
        containers = {
          open-webui.enable = true;
        };
      };

      server.containers.caddy-tailscale.blocks = [
        ''
          https://chat.xerus-augmented.ts.net {
            bind tailscale/chat

            reverse_proxy localhost:8040
          }

          https://search.xerus-augmented.ts.net {
            bind tailscale/search

            reverse_proxy localhost:8888
          }
        ''
      ];
    };
  }
