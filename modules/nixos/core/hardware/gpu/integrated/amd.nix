{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.core.hardware.gpu.integrated.amd;
in {
  options.${namespace}.core.hardware.gpu.integrated.amd.enable = lib.mkEnableOption "Enable integrated GPU features";

  config = lib.mkIf cfg.enable {
    ${namespace}.core.hardware.gpu.enable = true;

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
