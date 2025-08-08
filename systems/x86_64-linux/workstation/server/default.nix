{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server;
in {
  imports = [
    ./containers/caddy-tailscale.nix
    ./containers/jellyfin.nix
  ];

  options.server = with lib; {
    enable = mkEnableOption "Enable server config";
  };

  config = lib.mkIf cfg.enable {
    systemd.services = {
      create-docker-networks = {
        description = "Create docker networks for server";
        wantedBy = ["multi-user.target"];
        after = ["docker.service"];
        requires = ["docker.service"];

        serviceConfig = {
          Type = "oneshot";
        };

        path = with pkgs; [
          docker
        ];

        script = ''
          docker network create server_net
        '';
      };
    };

    virtualisation.oci-containers.backend = "docker";

    server.containers = {
      caddy-tailscale.enable = true;
      jellyfin.enable = true;
    };
  };
}
