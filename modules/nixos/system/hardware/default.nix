{
  lib,
  config,
  ...
}: let
  cfg = config.system.hardware;
in {
  imports = [
    ./intelgpu.nix
    ./amdgpu.nix
    ./nvidia.nix
  ];

  options.system.hardware.enable = lib.mkEnableOption "Enable hardware support";

  config = lib.mkIf cfg.enable {
    facter.reportPath = ../../../../facter/${config.networking.hostName}.json;

    services.fstrim.enable = true;
  };
}
