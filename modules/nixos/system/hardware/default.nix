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
    warnings =
      if config.system.vm.enable
      then [
        ''You have enabled virtualisation features on a platform you have requested be built for real hardware, please disable one as they conflict.''
      ] else [];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    environment.systemPackages = with pkgs; [
      nvtopPackages.full
    ];
  };
}
