{
  lib,
  config,
  ...
}: let
  cfg = config.core.hardware.gpu.dedicated.nvidia;
in {
  # TODO: configure dual specialization for laptops

  options.core.hardware.gpu.dedicated.nvidia.enable = lib.mkEnableOption "Enable NVIDIA GPU support";

  config = lib.mkIf (config.core.hardware.enable && config.core.hardware.gpu.enable && cfg.enable) {
    hardware.nvidia = {
      open = true;

      powerManagement = {
        enable = true;
        finegrained = true;
      };

      dynamicBoost.enable = true;
      modesetting.enable = true;

      prime = {
        intelBusId = lib.mkIf config.core.hardware.gpu.integrated.intel.enable "PCI:0:2:0";
        amdgpuBusId = lib.mkIf config.core.hardware.gpu.integrated.amd.enable "PCI:4:0:0";
        nvidiaBusId = "PCI:1:0:0";

        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };

    services.xserver.videoDrivers = ["nvidia"];
  };
}
