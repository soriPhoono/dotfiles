{
  lib,
  config,
  ...
}: let 
  cfg = config.server.containers.jellyfin;

  nodeName = "media";
in with lib; {
  options.server.containers.jellyfin = {
    enable = mkEnableOption "Enable jellyfin media server container";
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      jellyfin = {
        image = "jellyfin/jellyfin";

        extraOptions = ["--net=host"];
        
        volumes = [
          "/mnt/config/jellyfin/:/config"
          "/mnt/data/jellyfin/:/cache"
          "/mnt/media/:/media/"
        ];
      };
    };

    server.containers.caddy-tailscale.routes.${nodeName} = ''
      bind tailscale/${nodeName}
      reverse_proxy localhost:8096
    '';
  };
}