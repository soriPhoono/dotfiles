{
  lib,
  config,
  ...
}: let
  cfg = config.core.hardware.gpu.integrated.amd;
in {
  options.core.hardware.gpu.integrated.amd.enable = lib.mkEnableOption "Enable integrated GPU features";

  config = lib.mkIf cfg.enable {
    core.hardware.gpu.enable = true;

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
