{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.features.hosting;
in {
  options.desktop.features.hosting = {
    enable = lib.mkEnableOption "hosting features";
  };

  config = lib.mkIf cfg.enable {
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
      (lib.filterAttrs
        (name: content: content.admin)
        config.core.users);
  };
}
