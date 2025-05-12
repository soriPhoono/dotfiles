{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.core.hardware.gpu.dedicated.nvidia;
in {
  options.${namespace}.core.hardware.gpu.dedicated.nvidia = {
    enable = lib.mkEnableOption "Enable NVIDIA GPU support";

    laptopMode = lib.mkEnableOption "Enable laptop on-battery profile for system";
  };

  config = lib.mkIf cfg.enable {
    ${namespace}.core.hardware.gpu.enable = true;

    hardware.nvidia = {
      open = true;

      powerManagement = {
        enable = true;
      };

      dynamicBoost.enable = true;
      modesetting.enable = true;

      prime = {
        intelBusId = lib.mkIf config.${namespace}.core.hardware.gpu.integrated.intel.enable "PCI:0:2:0";
        amdgpuBusId = lib.mkIf config.${namespace}.core.hardware.gpu.integrated.amd.enable "PCI:4:0:0";
        nvidiaBusId = "PCI:1:0:0";

        offload = lib.mkIf cfg.laptopMode {
          enable = true;
          enableOffloadCmd = true;
        };

        sync.enable = lib.mkIf (!cfg.laptopMode) true;
      };
    };

    services.xserver.videoDrivers = ["nvidia"];
  };
}
