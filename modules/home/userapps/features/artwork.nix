{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.features.artwork;
in {
  options.userapps.features.artwork.enable = lib.mkEnableOption "Enable artwork applications";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      krita
      blender
    ];
  };
}
