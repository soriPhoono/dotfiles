{
  lib,
  config,
  ...
}: let
  cfg = config.server;
in {
  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d /services/ollama 0770 ${config.services.ollama.user} ${config.services.ollama.user} -"
    ];

    services = {
      ollama = {
        enable = true;

        user = "ollama";
        host = "localhost";

        home = "/services/ollama";
        acceleration = "rocm";

        loadModels = [
          "deepseek-coder-v2:236b"
        ];
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
