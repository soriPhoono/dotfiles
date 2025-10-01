{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.features.hosting;
in with lib; {
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
