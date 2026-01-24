{
  lib,
  config,
  ...
}: let
  cfg = config.hosting.backend.docker;
in
  with lib; {
    options.hosting.backend.docker = {
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
        builtins.mapAttrs (_name: _user: {
          extraGroups = [
            "docker"
          ];
        })
        (filterAttrs
          (_name: content: content.admin)
          config.core.users);
    };
  }
