{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hosting.kubernetes.multi-node.worker;
in
  with lib; {
    options.hosting.kubernetes.multi-node.worker = {
      enable = mkEnableOption "Enable multi-node Kubernetes worker configuration.";
      additionalManager = mkEnableOption "Whether this node should also act as a manager node.";

      leaderHostname = mkOption {
        type = types.str;
        description = "The hostname of the Kubernetes leader node to connect to.";
        default = "leader";
      };
    };

    config = mkIf cfg.enable {
      networking.firewall = {
        allowedTCPPorts = [6443 2379 2380 10250];
        allowedUDPPorts = [8472];
        trustedInterfaces = ["cni0" "flannel.1"];
        checkReversePath = "loose";
      };

      services.k3s = {
        enable = true;
        role =
          if cfg.additionalManager
          then "server"
          else "agent";
        tokenFile = config.sops.secrets."hosting/kubernetes/token".path;
        serverAddr = "https://${cfg.leaderHostname}:6443";

        gracefulNodeShutdown.enable = true;
      };
    };
  }
