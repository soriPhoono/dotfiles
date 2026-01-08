{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hosting.podman;
in
  with lib; {
    options.hosting.podman = {
      enable = mkEnableOption "Enable Podman container hosting service.";

      rootfulMode = mkEnableOption "Enable rootful Podman mode.";
    };

    config = mkIf cfg.enable {
      virtualisation.podman = {
        enable = true;
        autoPrune.enable = true;
        defaultNetwork.settings = {
          dns_enabled = true;
        };

        dockerCompat = cfg.rootfulMode;
        dockerSocket.enable = cfg.rootfulMode;
      };

      users.extraUsers =
        builtins.mapAttrs (name: user: {
          extraGroups = [
            "podman"
          ];
        })
        (filterAttrs
          (name: content: content.admin)
          config.core.users);
    };
  }
