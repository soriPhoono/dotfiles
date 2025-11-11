{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hosting;
in
  with lib; {
    options.hosting = {
      podman = {
        enable = mkEnableOption "Enable Docker hosting features";
      };

      kubernetes = {
        enable = mkEnableOption "Enable Kubernetes hosting features";
        mode = mkOption {
          type = types.enum ["master" "master-backup" "worker"];
          default = "master";
          description = "Kubernetes node mode.";
        };
      }; # TODO: finish this setup system
    };

    config = {
      virtualisation = mkIf cfg.podman.enable {
        podman = {
          enable = true;
          defaultNetwork.settings.dns_enabled = true;
          autoPrune.enable = true;
        };
      };

      users.extraUsers =
        mkIf cfg.podman.enable
        (builtins.mapAttrs (name: user: {
            extraGroups = [
              "podman"
            ];
          })
          (filterAttrs
            (name: content: content.admin)
            config.core.users));
    };
  }
