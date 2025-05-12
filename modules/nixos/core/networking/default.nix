{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.core.networking;
in {
  imports = [
    ./openssh.nix
  ];

  options.${namespace}.core.networking = {
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
