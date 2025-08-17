{
  lib,
  config,
  ...
}: let
  cfg = config.core.networking.network-manager;
in {
  options.core.networking.network-manager = {
    enable = lib.mkEnableOption "Enable network manager for managed networking on desktops";
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager = {
      enable = true;

      wifi = {
        powersave = true;
        macAddress = "random";
      };
    };

    users.extraUsers =
      builtins.mapAttrs (_: _: {
        extraGroups = [
          "networkmanager"
        ];
      })
      config.core.users;
  };
}
