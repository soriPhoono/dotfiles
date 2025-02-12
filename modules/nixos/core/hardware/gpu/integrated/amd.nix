{
  lib,
  config,
  ...
}: let
  cfg = config.core.hardware.gpu.integrated.amd;
in {
  options.core.hardware.gpu.integrated.amd.enable = lib.mkEnableOption "Enable integrated GPU features";

  config = lib.mkIf (config.core.hardware.enable && config.core.hardware.gpu.enable && cfg.enable) {
    hardware.amdgpu.initrd.enable = cfg.integrated.enable;

    services.xserver.videoDrivers = ["amdgpu"];

    environment = {
      variables = lib.mkIf cfg.integrated.enable {
        LIBVA_DRIVER_NAME = "radeonsi";
        VDPAU_DRIVER = "radeonsi";
      };
    };
  };
}
