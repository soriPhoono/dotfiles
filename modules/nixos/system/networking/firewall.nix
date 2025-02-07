{
  lib,
  config,
  ...
}: let
  cfg = config.system.networking;
in {
  config = lib.mkIf cfg.enable {
    networking.nftables.enable = true;
  };
}
