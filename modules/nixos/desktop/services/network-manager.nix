{ lib, config, ... }:
let
  cfg = config.desktop.services.network-manager;

  enableWifiPermissions = users: lib.mapAttrs (name: user: user // { extraGroups = [ "networkmanager" ]; }) users;
in
{
  options = {
    desktop.services.network-manager = {
      enable = lib.mkEnableOption "Enable network manager";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;

    users.users = enableWifiPermissions config.users.users;
  };
}
