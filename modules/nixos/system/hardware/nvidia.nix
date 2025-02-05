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

        dynamicBoost.enable = true;
        modesetting.enable = true;

        prime = {
          intelBusId = lib.mkIf config.system.hardware.intelgpu.integrated.enable "PCI:0:2:0";
          amdgpuBusId = lib.mkIf config.system.hardware.amdgpu.integrated.enable "PCI:4:0:0";
          nvidiaBusId = "PCI:1:0:0";

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
        nvtopPackages.full
      ];
    };
  };
}
