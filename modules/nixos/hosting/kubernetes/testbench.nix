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
      enable = lib.mkEnableOption "Kubernetes testbench setup";
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        minikube
        kubectl
        helm
      ];

      hosting.podman = {
        enable = true;
        rootfulMode = true;
      };
    };
  }
