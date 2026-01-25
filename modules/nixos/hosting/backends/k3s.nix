{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hosting.backend.k3s;
in
  with lib; {
    options.hosting.backend.k3s = {
      enable = mkEnableOption "Enable k3s in manager mode";
    };

    config = mkIf cfg.enable {
      networking.firewall = {
        allowedTCPPorts = [
          6443
          2379
          2380
        ];
        allowedUDPPorts = [
          8472
        ];
      };

      environment.systemPackages = with pkgs; [
        k3s
      ];
    };
  }
