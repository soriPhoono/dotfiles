{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.artwork;
in {
  options.userapps.artwork.enable = lib.mkEnableOption "Enable artwork applications";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      krita
      blender-hip
    ];
  };
}
