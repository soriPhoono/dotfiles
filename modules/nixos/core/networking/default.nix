{ lib, config, ... }:
let cfg = config.core.networking;
in {
  options = {
    core.networking = {
      networkManager.enable = lib.mkEnableOption "Enable NetworkManager";
      serverNetworking.enable = lib.mkEnableOption "Enable server networking";
    };
  };

  config = lib.mkIf cfg.networkManager.enable {
    networking = {
      networkmanager = {
        enable = true;

        wifi = {
          powersave = false;
        };
      };
    };

    users.users.soriphoono.extraGroups = [
      "networkmanager"
    ];
  };
}
