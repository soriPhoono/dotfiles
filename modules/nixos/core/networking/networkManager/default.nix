{ lib, config, ... }:
let cfg = config.core.networking.networkManager;
in {
  options = {
    core.networking.networkManager = {
      enable = lib.mkEnableOption "Enable NetworkManager";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager = {
      enable = true;

      wifi.powersave = false;
    };

    users.users.soriphoono.extraGroups = [
      "networkmanager"
    ];
  };
}
