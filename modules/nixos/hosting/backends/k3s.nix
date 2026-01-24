{
  lib,
  config,
  ...
}: let
  cfg = config.hosting.backend.k3s;
in
  with lib; {
    options.hosting.backend.k3s = {
      manager.enable = mkEnableOption "Enable k3s in manager mode";

      leaderIPAddress = mkOption {
        type =
          if cfg.manager.enable
          then with types; nullOr str
          else types.str;
        default = mkIf cfg.manager.enable null;
        description = "IP Address of the leader node of the cluster";
        example = "192.168.1.50";
      };
    };

    config = {
      assertions = [
        {
          assertions = !((!cfg.manager.enable) && (cfg.leaderIPAddress == null));
          message = "All worker nodes are required to join a cluster upon creation";
        }
      ];

      sops.secrets."hosting/k3s_token" = {};

      services.k3s = {
        enable = true;
        role =
          if cfg.manager.enable
          then "server"
          else "agent";
        tokenFile = config.sops.secrets."hosting/k3s_token".path;
        clusterInit = cfg.manager.enable && (cfg.leaderIPAddress == null);
        serverAddr = lib.mkIf (cfg.leaderIPAddress != null) "https://${cfg.leaderIPAddress}:6443";
      };
    };
  }
