{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hosting.docker.standalone;
in {
  options.hosting.docker.standalone = {
    enable = lib.mkEnableOption "Standalone Docker hosting features";

    mode = lib.mkOption {
      type = lib.types.enum ["server" "agent"];
      default = "agent";
      description = "The mode in which to run the standalone Docker hosting.";
    };
  };

  config = lib.mkIf cfg.enable {
    hosting.docker.enable = true;

    virtualisation.oci-containers = {
      backend = "docker";

      containers = {
        "portainer-server-be" = lib.mkIf (cfg.mode == "server") {
          image = "portainer/portainer-ee:lts";
          volumes = [
            "portainer_data:/data"
          ];
          networks = [
            "portainer_agent_network"
            "reverse_proxy_network"
          ];
          ports = ["9443:9443" "8000:8000"];
        };
        "portainer-agent" = lib.mkIf (cfg.mode == "agent" || cfg.mode == "server") {
          image = "portainer/agent:lts";
          volumes = [
            "/var/run/docker.sock:/var/run/docker.sock"
            "/var/lib/docker/volumes:/var/lib/docker/volumes"
            "/:/host"
          ];
          networks = lib.mkIf (cfg.mode == "server") [
            "portainer_agent_network"
          ];
        };
      };
    };

    systemd.services."create-core-networks" = {
      serviceConfig.type = "oneshot";
      wantedBy = ["docker.service"];
      script = ''
        ${pkgs.docker}/bin/docker network inspect portainer_agent_network > /dev/null 2>&1 || \
          ${pkgs.docker}/bin/docker network create portainer_agent_network
        ${pkgs.docker}/bin/docker network inspect reverse_proxy_network > /dev/null 2>&1 || \
          ${pkgs.docker}/bin/docker network create reverse_proxy_network --subnet 192.168.25.0/24
      '';
    };
  };
}
