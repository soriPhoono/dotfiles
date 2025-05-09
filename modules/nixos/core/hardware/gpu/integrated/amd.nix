{
  lib,
  config,
  ...
}: let
  cfg = config.core.hardware.gpu.integrated.amd;
in {
  options.core.hardware.gpu.integrated.amd.enable = lib.mkEnableOption "Enable integrated GPU features";

  config = lib.mkIf (config.core.hardware.gpu.enable && cfg.enable) {
    hardware.amdgpu.initrd.enable = true;

    services.xserver.videoDrivers = ["amdgpu"];

    environment = {
      variables = {
        LIBVA_DRIVER_NAME = "radeonsi";
        VDPAU_DRIVER = "radeonsi";
      };
    };
  };
}
