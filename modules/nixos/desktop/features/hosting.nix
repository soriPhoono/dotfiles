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

    config = mkIf cfg.enable {
      virtualisation = {
        docker = {
          enable = true;
          enableOnBoot = true;
          autoPrune.enable = true;
          rootless.enable = true;
        };

        oci-containers = {
          backend = "docker";

          containers."portainer" = {
            image = "portainer/portainer-ee:lts";
            restart = "always";
            volumes = [
              "/var/run/docker.sock:/var/run/docker.sock",
              "portainer_data:/data"
            ];
            ports = [ "9443:9443" ];
          };
        };
      };

      systemd.services."create-core-networks" = {
        serviceConfig.type = "oneshot";
        wantedBy = [ "docker.service" ];
        script = ''
          ${pkgs.docker}/bin/docker network inspect core_network > /dev/null 2>&1 || \
            ${pkgs.docker}/bin/docker network create core_network --subnet 192.168.25.0/24
        '';
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
