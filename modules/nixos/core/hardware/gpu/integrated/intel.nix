{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.core.hardware.gpu.integrated.intel;
in {
  options.${namespace}.core.hardware.gpu.integrated.intel = {
    enable = lib.mkEnableOption "Enable igpu features for intel igpus";

    device_id = lib.mkOption {
      type = lib.types.str;
      description = "The igpu device id to detect on later generation gpus (mandatory on 12 gen or later)";

      default = null;
    };
  };

  config = lib.mkIf cfg.enable {
    ${namespace}.core.hardware.gpu.enable = true;

    boot.kernelParams = lib.mkIf (cfg.device_id != null) [
      "i915.force_probe=${cfg.device_id}"
    ];

    hardware.graphics.extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
    ];

    services.xserver.videoDrivers = ["intel"];

    environment.variables = {
      LIBVA_DRIVER_NAME = "iHD";
      VDPAU_DRIVER = "va_gl";
    };
  };
}
