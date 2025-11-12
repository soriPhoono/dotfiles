{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.docker;
in
  with lib; {
    options.docker = {
      enable = mkEnableOption "Enable Docker support";

      mode = mkOption {
        type = types.enum ["standalone" "swarm-manager" "swarm-submanager" "swarm-worker"];
        default = "standalone";
        description = ''
          Set the Docker mode.
        '';
      };
    };

    config = mkIf cfg.enable (mkMerge [
      {
        virtualisation.docker = {
          enable = true;
          autoPrune.enable = true;
        };

        users.extraUsers =
          builtins.mapAttrs (name: user: {
              extraGroups = [
                "docker"
              ];
            })
            (filterAttrs
              (name: content: content.admin)
              config.core.users);
      }
      (mkIf (cfg.mode == "swarm-manager") {

      })
      (mkIf (cfg.mode == "swarm-submanager") {

      })
      (mkIf (cfg.mode == "swarm-worker") {

      })
    ]);
  }
