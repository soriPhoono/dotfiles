{
  lib,
  pkgs,
  config,
  virtual,
  ...
}: let
  cfg = config.system.hardware.intelgpu;
in {
  options.system.hardware.intelgpu = {
    integrated = {
      enable = lib.mkEnableOption "Enable igpu features for intel igpus";

      device_id = lib.mkOption {
        type = lib.types.str;
        description = "The igpu device id to detect on later generation gpus";
      };
    };
  };

  config = lib.mkIf (!virtual && cfg.integrated.enable) {
    boot.kernelParams = lib.mkIf cfg.integrated.enable [
      "i915.force_probe=${cfg.integrated.device_id}"
    ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs;
        lib.mkIf cfg.integrated.enable [
          intel-media-driver
          libvdpau-va-gl
        ];
    };

    services.xserver.videoDrivers = ["intel"];

    environment = {
      systemPackages = with pkgs; [
        nvtopPackages.full
      ];

      variables = lib.mkIf cfg.integrated.enable {
        LIBVA_DRIVER_NAME = "iHD";
        VDPAU_DRIVER = "va_gl";
      };
    };

    services.thermald.enable = cfg.integrated.enable;
  };
}
