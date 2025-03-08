{
  lib,
  pkgs,
  config,
  nixosConfig,
  ...
}: let
  cfg = config.userapps.artwork;
in {
  options.userapps.artwork.enable = lib.mkEnableOption "Enable artwork applications";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      krita
      (lib.mkIf (nixosConfig != null && !nixosConfig.core.hardware.gpu.dedicated.amd.enable) pkgs.blender)
      (lib.mkIf (nixosConfig != null && nixosConfig.core.hardware.gpu.dedicated.amd.enable) pkgs.blender-hip)
    ];
  };
}
