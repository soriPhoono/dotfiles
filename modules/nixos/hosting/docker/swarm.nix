{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hosting.docker.swarm;
in with lib; {
  options.hosting.docker.swarm = {
    enable = mkEnableOption "Docker Swarm hosting features";

    managerConfiguration = mkOption {
      type = with types; nullOr (enum [ "manager-server" "manager-agent" ]);
      default = null;
      description = ''
        The configuration for the Swarm manager node. If set to "manager-server",
        the node will run the Swarm manager and deploy Portainer server and agent. If set to
        "manager-agent", it will run the Swarm manager without Portainer server, just agent
        for control from a separate portainer server node.
      '';
    };
  };

  config = mkIf cfg.enable {
    hosting.docker.enable = true;

    
  };
}
