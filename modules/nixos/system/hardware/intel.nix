{ lib, pkgs, config, ... }:
let
  cfg = config.hardware.intel;
in
{
  options.hardware.intel = {
    enable = lib.mkEnableOption "Enable intel drivers";
  };

  config = lib.mkIf cfg.enable {
    hardware.gpu.enable = true;

    boot.kernelParams = [
      # "i915.force_probe=" # TODO: get igpu device id with nix-shell -p pciutils --run "lspci -nn | grep VGA"
    ];

    environment.variables = {
      LIBVA_DRIVER_NAME = "iHD";
      VDPAU_DRIVER = "va_gl";
    };

    hardware.graphics.extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
    ];
  };
}
