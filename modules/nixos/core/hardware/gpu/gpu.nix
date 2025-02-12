{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.hardware.gpu;
in {
  imports = [
    ./dedicated/amd.nix
    # ./dedicated/intel.nix
    ./dedicated/nvidia.nix

    ./integrated/amd.nix
    ./integrated/intel.nix
  ];

  options.core.hardware.gpu.enable = lib.mkEnableOption "Enable gpu related features";

  config = lib.mkIf (config.core.hardware.enable && cfg.enable) {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    environment.systemPackages = with pkgs; [
      nvtopPackages.full
    ];
  };
}
