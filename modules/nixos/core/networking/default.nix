{
  lib,
  config,
  ...
}: let
  cfg = config.core.networking;
in {
  imports = [
    ./openssh.nix
    ./network-manager.nix
    ./tailscale.nix
  ];

  options.core.networking = {
    enable = lib.mkEnableOption "Enable system networking";
  };

  config = {
    networking = {
      wireless.enable = cfg.enable;
      nftables.enable = true;
    };

    services.resolved.enable = true;
  };
}
