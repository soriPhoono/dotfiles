{
  lib,
  config,
  ...
}: let
  cfg = config.core.hardware;
in {
  imports = [
    ./gpu/gpu.nix

    ./ssd.nix
  ];

  options.core.hardware.enable = lib.mkEnableOption "Enable hardware support";

  config = lib.mkIf cfg.enable {
    facter.reportPath = ../../../../facter/${config.networking.hostName}.json;
  };
}
