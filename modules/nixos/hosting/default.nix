{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hosting;
in
  with lib; {
    imports = [
      ./docker/standalone.nix
    ];

    options.hosting = {
      docker = {
        enable = mkEnableOption "Enable Docker hosting features";
      };
    };

    config = {
      virtualisation.docker = mkIf cfg.docker.enable {
        enable = true;
        enableOnBoot = true;
        autoPrune.enable = true;
        rootless.enable = true;
      };

      users.extraUsers =
        mkIf cfg.docker.enable
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
