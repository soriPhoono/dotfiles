{
  lib,
  config,
  ...
}: let
  cfg = config.server.ollama;
in {
  options.server.ollama.enable = lib.mkEnableOption "Enable ollama self hosted artificial intelligence";

  config = lib.mkIf cfg.enable {
    server = {
      ldap.enable = true;
    };

    sops = {
      secrets."server/searx_seed" = {};
      templates.searx_secrets.content = ''
        SEARX_SECRET_KEY=${config.sops.placeholder."server/searx_seed"}
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

        environment = {
          ENABLE_LDAP = "true";
        };
      };

      caddy.virtualHosts = {
        "https://chat.${config.core.networking.tailscale.tn_name}" = {
          extraConfig = ''
            bind tailscale/chat
            reverse_proxy localhost:3000
          '';
        };
      };

      homepage-dashboard.services = [
        {
          "Development" = [
            {
              "Ollama" = {
                description = "Personal instance of ollama for selfhosted artificial intelligence";
                href = "https://chat.${config.core.networking.tailscale.tn_name}";
              };
            }
          ];
        }
      ];
    };
  };
}
