{ lib, config, ... }: 
let cfg = config.cli.networking;
in {
  options.cli.networking = {
    network-manager = lib.mkEnableOption "Enable NetworkManager";
  };

  config = {
    networking.networkmanager.enable = lib.mkIf cfg.network-manager true;

    # TODO: add ssh configuration
  };
}