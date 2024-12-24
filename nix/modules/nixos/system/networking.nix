{ lib, config, ... }:
let cfg = config.system.networking;
in {
  options.system.networking = {
    network-manager = lib.mkEnableOption "Enable NetworkManager";
  };

  config = {
    networking.networkmanager.enable = lib.mkIf cfg.network-manager true;

    # TODO: add ssh configuration
  };
}
