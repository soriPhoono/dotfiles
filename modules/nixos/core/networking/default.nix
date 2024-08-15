{ lib, config, ... }:
let cfg = config.core.networking.networkManager;
in {
  options = {
    core.networking = {
      networkManager.enable = lib.mkEnableOption "Enable NetworkManager";
    };
  };

  config = {
    networking.networkmanager = lib.mkIf cfg.enable {
      enable = true;

      wifi.powersave = false;
    };

    users.users.soriphoono.extraGroups = lib.mkIf cfg.enable [
      "networkmanager"
    ];
  };
}
