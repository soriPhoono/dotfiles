{ lib, pkgs, config, ... }:
let
  this = "system.hardware.gpu.intel";

  cfg = config."${this}";
in
{
  options."${this}" = {
    enable = lib.mkEnableOption "Enable intel igpu drivers";

    internal = {
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

  config = lib.mkIf cfg.enable {
    boot.kernelParams = lib.mkIf cfg.internal.enable [
      "i915.force_probe=${cfg.internal.device_id}"
    ];

    environment.variables = lib.mkIf (cfg.dedicated.enable && cfg.dedicated.acceleration) {
      LIBVA_DRIVER_NAME = "iHD";
      VDPAU_DRIVER = "va_gl";
    };

    hardware.graphics.extraPackages = with pkgs; lib.mkIf (cfg.dedicated.enable && cfg.dedicated.acceleration) [
      intel-media-driver
      libvdpau-va-gl
    ];

    services.thermald.enable = cfg.internal.enable;
  };
}
