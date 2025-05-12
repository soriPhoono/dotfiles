{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.core.networking.network-manager;
in {
  options.${namespace}.core.networking.network-manager = {
    enable = lib.mkEnableOption "Enable network manager for managed networking on desktops";
  };

  config = lib.mkIf cfg.enable {
    systemd.network.wait-online.enable = false;

    networking.networkmanager = {
      enable = true;

      dhcp = "dhcpcd";

      wifi = {
        powersave = true;
        macAddress = "random";
      };
    };

    users.extraUsers = lib.listToAttrs (
      map (user: {
        inherit (user) name;

        value = {
          extraGroups = [
            "networkmanager"
          ];
        };
      })
      config.${namespace}.core.users
    );
  };
}
