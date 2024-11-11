{ lib, config, ... }:
let
  cfg = config.desktop.services.network-manager;
in
{
  options = {
    desktop.services.network-manager = {
      enable = lib.mkEnableOption "Enable network manager";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;

    users.users.soriphoono.extraGroups = [ "networkmanager" ];
  };
}
