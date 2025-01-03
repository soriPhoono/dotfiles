{ lib, pkgs, config, ... }:
let
  cfg = config.hardware.gpu;
in {
  imports = [
    ./intel.nix
    ./amdgpu.nix
  ];

  options.hardware.gpu = {
    enable = lib.mkEnableOption "Enable graphics support";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    environment.systemPackages = with pkgs; [
      nvtopPackages.full
    ];
  };
}
