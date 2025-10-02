{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.features.hosting;
in
  with lib; {
    options.desktop.features.hosting = {
      enable = mkEnableOption "hosting features";
    };

    # TODO: fix group assignment to be inline with users.nix
    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        docker-compose
      ];

      virtualisation = {
        docker = {
          enable = true;
          autoPrune.enable = true;
          rootless.enable = true;
        };

        oci-containers = {
          backend = "docker";
          containers.portainer = {
            image = "portainer/portainer-ce:lts";
            volumes = [
              "/var/run/docker.sock:/var/run/docker.sock"
              "portainer_data:/data"
            ];
            ports = [
              "9443:9443"
            ];
          };
        };
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
