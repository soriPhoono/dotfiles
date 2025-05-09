{
  lib,
  config,
  ...
}: let
  cfg = config.core.networking;
in {
  imports = [
    ./wireless.nix
    ./openssh.nix
    ./tailscale.nix
  ];

  options.core.networking.enable = lib.mkEnableOption "Enable networking";

  config = lib.mkIf cfg.enable {
    networking.nftables.enable = true;

    services = {
      timesyncd.enable = true;
    };
  };
}
