{
  lib,
  config,
  ...
}: let
  cfg = config.server.services.homepage;
in {
  options.server.services.homepage.enable = lib.mkEnableOption "Enable homepage dashboard";

  config = lib.mkIf cfg.enable {
    services = {
      homepage-dashboard = {
        openFirewall = true;

        services = [
          {
            "Office" = [
              {
                "Nextcloud" = {
                  description = "Nextcloud workspace drive";
                  href = "https://workstation.xerus-augmented.ts.net/nextcloud/";
                };
              }
            ];
          }
          {
            "Media" = [
              {
                "JellyFin" = {
                  description = "JellyFin media server";
                  href = "https://workstation.xerus-augmented.ts.net/jellyfin/";
                };
              }
            ];
          }
        ];
      };
    };
  };
}
