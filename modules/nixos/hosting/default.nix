{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.docker;
in
  with lib; {
    options = {
      hosting = {
        enable = mkEnableOption "Enable Kubernetes support";

        deploymentType = mkOption {
          type = types.enum [ "testbench" "production" ];
        };
      };
    };

    config = mkIf cfg.enable (mkMerge [
      (mkIf (cfg.deploymentType == "testbench") {

      })
      (mkIf (cfg.deploymentType == "production") {

      })
    ]);
  }
