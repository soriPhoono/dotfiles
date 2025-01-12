{ lib, config, ... }:
let
  this = "system.networking";

  cfg = config."${this}";
in
{
  options."${this}" = {
    enable = lib.mkEnableOption "Enable networking";
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.enable = true;
    networking.nftables.enable = true;

    networking.networkmanager.enable = true;

    users.users.${config.core.admin.name}.extraGroups = [ "networkmanager" ];

    services.timesyncd.enable = true;
  };
}
