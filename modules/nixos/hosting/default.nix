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
    };

    config = mkIf cfg.enable {
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
    };
  }
