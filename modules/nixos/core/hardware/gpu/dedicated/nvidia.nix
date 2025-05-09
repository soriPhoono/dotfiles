{
  lib,
  config,
  ...
}: let
  cfg = config.core.hardware.gpu.dedicated.nvidia;
in {
  options.core.hardware.gpu.dedicated.nvidia = {
    enable = lib.mkEnableOption "Enable NVIDIA GPU support";

    laptopMode = lib.mkEnableOption "Enable laptop on-battery profile for system";
  };

  config = lib.mkIf (config.core.hardware.gpu.enable && cfg.enable) {
    hardware.nvidia = {
      open = true;

      powerManagement = {
        enable = true;
      };

      dynamicBoost.enable = true;
      modesetting.enable = true;

      prime = {
        intelBusId = lib.mkIf config.core.hardware.gpu.integrated.intel.enable "PCI:0:2:0";
        amdgpuBusId = lib.mkIf config.core.hardware.gpu.integrated.amd.enable "PCI:4:0:0";
        nvidiaBusId = "PCI:1:0:0";

        sync.enable = true;
      };
    };

    services.xserver.videoDrivers = ["nvidia"];

    specialisation = {
      "on-battery".configuration = lib.mkIf cfg.laptopMode {
        system.nixos.tags = ["laptop-mode"];
        hardware.nvidia = {
          powerManagement.finegrained = lib.mkForce true;
          prime = {
            sync.enable = lib.mkForce false;
            offload = {
              enable = lib.mkForce true;
              enableOffloadCmd = lib.mkForce true;
            };
          };
        };
      };
    };
  };
}
