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

  config = if cfg.enable then {
    networking.nftables.enable = true;

    services = {
      resolved.enable = true;
    };
  } else {
    networking = {
      wireless.enable = true;
      nftables.enable = true;
    };
  };
}
