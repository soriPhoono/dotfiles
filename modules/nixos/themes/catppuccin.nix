{ lib, pkgs, config, ... }:
let
  this = "themes.catppuccin";

  cfg = config."${this}";
in {
  options."${this}".enable =
    lib.mkEnableOption "Enable catppuccin desktop theming";

  config = lib.mkIf cfg.enable {
    stylix = {
      image = ../../../assets/wallpapers/catppuccin-mountain.jpg;

      base16Scheme =
        "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
    };
  };
}
