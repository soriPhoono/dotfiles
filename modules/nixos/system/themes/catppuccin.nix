{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.system.themes.catppuccin;
in {
  options.system.themes.catppuccin.enable = lib.mkEnableOption "Enable catppuccin colorscheme";

  config = lib.mkIf cfg.enable {
    stylix = {
      image = ../../../../assets/wallpapers/catppuccin-mountain.jpg;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
    };
  };
}
