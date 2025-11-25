{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hosting.kubernetes.single-node;
in
  with lib; {
    options.hosting.kubernetes.single-node = {
      enable = mkEnableOption "Enable single-node Kubernetes configuration.";
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
        role = "server";

        gracefulNodeShutdown.enable = true;
      };
    };
  }
