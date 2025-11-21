{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hosting.kubernetes.testbench;
in
  with lib; {
    options.hosting.kubernetes.testbench = {
      enable = mkEnableOption "Enable single-node Kubernetes configuration.";
    };

    config = mkIf cfg.enable {
      networking.firewall = {
        allowedTCPPorts = [6443 2379 2380];
        allowedUDPPorts = [8472];
      };

      hosting.docker.enable = true;
    };
  }
