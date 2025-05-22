{
  lib,
  config,
  ...
}: let
  cfg = config.server;
in {
  config = lib.mkIf cfg.enable {
    services = {
      jellyfin = {
        enable = true;

        dataDir = "/mnt/jellyfin/";
      };

      caddy.virtualHosts = {
        "jellyfin.xerus-augmented.ts.net" = {
          extraConfig = ''
            bind tailscale/jellyfin
            reverse_proxy localhost:8096
          '';
        };
      };
    };
  };
}
