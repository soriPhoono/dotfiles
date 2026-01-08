{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hosting.docker;
in
  with lib; {
    options.hosting.docker = {
      enable = mkEnableOption "Enable Docker hosting support.";
    };

    config = {
      virtualisation = {
        docker = mkIf cfg.enable {
          enable = true;
          autoPrune.enable = true;
        };
        oci-containers.backend = "docker";
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
    };
  }
