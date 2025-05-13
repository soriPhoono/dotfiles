{
  lib,
  config,
  ...
}: let
  cfg = config.core.hardware.gpu;
in {
  imports = [
    ./dedicated/amd.nix
    ./dedicated/nvidia.nix
    ./integrated/amd.nix
    ./integrated/intel.nix
  ];

  options.core.hardware.gpu = {
    enable = lib.mkEnableOption "Enable graphics driver features";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
