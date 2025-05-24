{
  lib,
  config,
  ...
}: let
  cfg = config.server;
in {
  config = lib.mkIf cfg.enable {
    sops = {
      secrets.searx_secret = {};
      templates.searx_secrets.content = ''
        SEARX_SECRET_KEY=${config.sops.placeholder.searx_secret}
      '';
    };

    systemd.tmpfiles.rules = [
      "d /services/ollama 0770 ${config.services.ollama.user} ${config.services.ollama.user} -"
    ];

    services = {
      searx = {
        enable = true;
        redisCreateLocally = true;
        environmentFile = config.sops.templates.searx_secrets.path;
        settings = {
          server = {
            port = 8000;
            bind_address = "localhost";
            secret_key = "@SEARX_SECRET_KEY@";
          };
          search.formats = [
            "html"
            "json"
          ];
        };
      };

      ollama = {
        enable = true;

        user = "ollama";
        host = "localhost";

        home = "/services/ollama";
        acceleration = "rocm";
      };

      open-webui = {
        enable = true;

        host = "localhost";
        port = 3000;
      };

      caddy.virtualHosts = {
        "ai.xerus-augmented.ts.net" = {
          extraConfig = ''
            bind tailscale/ai
            reverse_proxy localhost:3000
          '';
        };
      };
    };
  };
}
