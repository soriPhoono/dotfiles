{
  lib,
  config,
  ...
}: let
  cfg = config.core.networking.wireless;
in {
  options.core.networking.wireless = {
    enable = lib.mkEnableOption "Enable wireless networking";
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
      config.core.suites.users.users
    );

    core.boot.impermanence.directories = [
      "/etc/NetworkManager/system-connections/"
    ];
  };
}
