{
  lib,
  config,
  ...
}: let
  cfg = config.server.firefox-syncserver;
in {
  options.server.firefox-syncserver.enable = lib.mkEnableOption "Enable firefox-syncserver";

  config = lib.mkIf cfg.enable {
    services = {
      firefox-syncserver.singleNode = {
        enable = true;
        hostname = "sync.xerus-augmented.ts.net";
        url = "https://sync.xerus-augmented.ts.net";
      };

      caddy.virtualHosts.${config.services.firefox-syncserver.singleNode.url}.extraConfig = ''
        bind tailscale/sync
        reverse_proxy localhost:${builtins.toString config.services.firefox-syncserver.settings.port}
      '';
    };
  };
}
