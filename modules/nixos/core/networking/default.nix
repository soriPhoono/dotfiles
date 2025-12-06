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

  config = {
    networking = {
      nftables.enable = true;
    };

    services.resolved.enable = true;
  };
}
