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
  ];

  options.core.networking.enable = lib.mkEnableOption "Enable networking";

  config = lib.mkIf cfg.enable {
    networking = {
      nameservers = [
        "1.1.1.1"
        "1.0.0.1"
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
