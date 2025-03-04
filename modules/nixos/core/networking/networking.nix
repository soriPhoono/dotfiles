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
    networking = {
      nameservers = [
        "100.100.100.100"
        "1.1.1.1"
        "1.0.0.1"
      ];

      search = [
        "tail75adb.ts.net"
      ];

      nftables.enable = true;
    };

    services = {
      resolved = {
        enable = true;
        fallbackDns = config.networking.nameservers;
      };

      timesyncd.enable = true;
    };
  };
}
