{
  lib,
  config,
  ...
}: let
  cfg = config.server.containers.readarr;
in
  with lib; {
    options.server.containers.readarr = {
      enable = mkEnableOption "Enable readarr download manager";
    };

    config = mkIf cfg.enable {
      virtualisation.oci-containers.containers = {
        readarr = {
          image = "ghcr.io/pennydreadful/bookshelf:hardcover";

          volumes = [
            "/mnt/config/readarr:/config"
            "/mnt/media/Books:/books"
            "/mnt/media/Torrent:/downloads"
          ];

          networks = [
            "multimedia_network"
          ];

          ports = [
            "8787:8787"
          ];
        };
      };
    };
  }
