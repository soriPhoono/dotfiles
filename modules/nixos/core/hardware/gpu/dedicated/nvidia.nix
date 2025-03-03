{
  lib,
  config,
  ...
}: let
  cfg = config.core.hardware.gpu.dedicated.nvidia;
in {
  options.core.hardware.gpu.dedicated.nvidia = {
    enable = lib.mkEnableOption "Enable NVIDIA GPU support";

    mode = lib.mkOption {
      type = lib.types.enum ["laptop" "desktop" "both"];
      default = "both";
      description = "Configure GPU mode for laptops and desktops";
    };
  };

  config = lib.mkIf (config.core.hardware.enable && config.core.hardware.gpu.enable && cfg.enable) {
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
      };
    };

    services.xserver.videoDrivers = ["nvidia"];

    specialisation = {
      "on-battery".configuration = lib.mkIf (cfg.mode == "both" || cfg.mode == "laptop") {
        system.nixos.tags = ["laptop-mode"];
        hardware.nvidia = {
          powerManagement.finegrained = true;
          prime.offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };
      };
      "on-ac".configuration = lib.mkIf (cfg.mode == "both" || cfg.mode == "desktop") {
        system.nixos.tags = ["desktop-mode"];
        hardware.nvidia.prime = {
          sync.enable = true;
        };
      };
    };
  };
}
