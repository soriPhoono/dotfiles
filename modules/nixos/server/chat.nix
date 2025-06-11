{
  lib,
  config,
  ...
}: let
  cfg = config.server.chat;

  ollama_data_dir = "/services/ollama/";

  open-webuiEndpoint = "https://chat.${config.core.networking.tailscale.tn_name}";
in {
  options.server.chat.enable = lib.mkEnableOption "Enable ollama self hosted artificial intelligence";

  config = lib.mkIf cfg.enable {
    sops = {
      secrets."server/searx_seed" = {};
      templates.searx_secrets.content = ''
        SEARX_SECRET_KEY=${config.sops.placeholder."server/searx_seed"}
      '';
    };

    systemd = {
      tmpfiles.rules = [
        "d ${ollama_data_dir} 0770 ${config.services.ollama.user} ${config.services.ollama.user} -"
      ];
    };

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

        home = ollama_data_dir;
        acceleration = "rocm";
      };

      open-webui = {
        enable = true;

        host = "localhost";
        port = 3000;
      };

      caddy.virtualHosts = {
        ${open-webuiEndpoint} = {
          extraConfig = ''
            bind tailscale/chat
            reverse_proxy localhost:${builtins.toString config.services.open-webui.port}
          '';
        };
      };

      homepage-dashboard.services = [
        {
          "Development" = [
            {
              "Chat interface" = {
                description = "Artificial intelligence LLM";
                href = open-webuiEndpoint;
                icon = "sh-ollama";
              };
            }
          ];
        }
      ];
    };
  };
}
