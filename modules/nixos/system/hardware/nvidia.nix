{
  lib,
  pkgs,
  config,
  virtual,
  ...
}: let
  cfg = config.system.hardware.nvidia;
in {
  options.system.hardware.nvidia = {
    enable = lib.mkEnableOption "Enable NVIDIA GPU support";

    acceleration = lib.mkOption {
      type = lib.types.bool;
      description = "Enable hardware acceleration features on NVIDIA GPUS";

      default = true;
    };
  };

  config = lib.mkIf (!virtual && cfg.enable) {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };

      nvidia = {
        open = true;

        powerManagement = {
          enable = true;
          finegrained = true;
        };

        dynamicBoost = {
          enable = true;
        };

        prime = {
          intelBusId = lib.mkIf config.system.hardware.intelgpu.integrated.enable "PCI:0:2:0";
          amdgpuBusId = lib.mkIf config.system.hardware.amdgpu.integrated.enable "PCI:4:0:0";

          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };
      };
    };

    services.xserver.videoDrivers = ["nvidia"];

    environment = {
      systemPackages = with pkgs; [
        nvtop
      ];

      variables = lib.mkIf (cfg.enable && cfg.acceleration) {
        LIBVA_DRIVER_NAME = "nvidia";
        VDPAU_DRIVER = "nvidia";
      };
    };
  };
}
