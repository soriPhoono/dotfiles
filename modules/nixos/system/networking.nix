{ lib, config, ... }:
let
  cfg = config.system.networking;
in
{
  options.system.networking = {
    enable = lib.mkEnableOption "Enable networking";
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.enable = true;
    networking.nftables.enable = true;

    networking.networkmanager.enable = true;

    users.users.${lib.dotfiles.to_unix_name config.core.admin.name}.extraGroups = [ "networkmanager" ];

    services.timesyncd.enable = true;
  };
}
