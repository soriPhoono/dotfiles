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
    ./homepage-dashboard.nix
    ./protonmail-bridge.nix
  ];

  options.core.networking = {
    enable = lib.mkEnableOption "Enable system networking";
  };

  config = lib.mkIf cfg.enable {
    networking.nftables.enable = true;

    services = {
      resolved.enable = true;
      timesyncd.enable = true;
    };
  };
}
