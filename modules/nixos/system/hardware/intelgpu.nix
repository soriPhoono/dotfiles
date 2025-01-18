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

    dedicated = {
      enable = lib.mkEnableOption "Enable dedicated intel gpu support";

      acceleration = lib.mkOption {
        type = lib.types.bool;
        description = "Enable hardware accleration features on this hardware";

        default = true;
      };
    };
  };

  config = lib.mkIf (!virtual && (cfg.integrated.enable || cfg.dedicated.enable)) {
    boot.kernelParams = lib.mkIf cfg.integrated.enable [
      "i915.force_probe=${cfg.integrated.device_id}"
    ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs;
        lib.mkIf (cfg.dedicated.enable && cfg.dedicated.acceleration) [
          intel-media-driver
          libvdpau-va-gl
        ];
    };

    environment = {
      systemPackages = with pkgs; [
        nvtop
      ];

      variables = lib.mkIf (cfg.dedicated.enable && cfg.dedicated.acceleration) {
        LIBVA_DRIVER_NAME = "iHD";
        VDPAU_DRIVER = "va_gl";
      };
    };

    services.thermald.enable = cfg.integrated.enable;
  };
}
