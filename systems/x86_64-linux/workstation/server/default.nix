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
  ];

  options.server = with lib; {
    enable = mkEnableOption "Enable server config";

    networks = mkOption {
      type = with types; listOf str;
      default = [];
      example = ["server_network"];
      description = "The list of names of networks to create in docker";
    };
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

        script =
          builtins.concatStringsSep
          "\n"
          (map
            (network_name: ''
              if ! docker network ls | grep -q ${network_name}; then
                docker network create ${network_name}
              else
                echo "Network ${network_name} already exists!"
              fi
            '')
            cfg.networks);
      };
    };

    virtualisation.oci-containers.backend = "docker";

    server.containers.caddy-tailscale.enable = true;
  };
}
