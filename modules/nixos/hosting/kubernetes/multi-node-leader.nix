{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hosting.kubernetes.multi-node.leader;
in
  with lib; {
    options.hosting.kubernetes.multi-node.leader = {
      enable = mkEnableOption "Enable multi-node Kubernetes leader configuration.";
    };

    config = mkIf cfg.enable {
      networking.firewall = {
        allowedTCPPorts = [6443 2379 2380];
        allowedUDPPorts = [8472];
      };

      services.k3s = {
        enable = true;
        role = "server";
        tokenFile = config.sops.secrets."hosting/kubernetes/token".path;
        clusterInit = true;

        gracefulNodeShutdown.enable = true;
      };
    };
  }
