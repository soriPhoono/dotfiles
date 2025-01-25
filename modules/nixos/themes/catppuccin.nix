{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.themes.catppuccin;
in {
  options.themes.catppuccin.enable = lib.mkEnableOption "Enable catppuccin colorscheme";

  config = lib.mkIf cfg.enable {
    stylix = {
      image = ../../../../assets/wallpapers/catppuccin-mountain.jpg;
    };
  };
}
