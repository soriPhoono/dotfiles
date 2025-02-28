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

      insertNameservers = config.networking.nameservers;

      wifi = {
        powersave = true;
        macAddress = "random";
      };

      ethernet.macAddress = "random";
    };

    users.users =
      lib.genAttrs config.core.users.users
      (_: {
        extraGroups = ["networkmanager"];
      });

    core.boot.impermanence.directories = [
      "/etc/NetworkManager/system-connections/"
    ];
  };
}
