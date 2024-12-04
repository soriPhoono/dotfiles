{ lib, pkgs, config, ... }:
let cfg = config.themes.catppuccin;
in {
  options.themes.catppuccin.enable =
    lib.mkEnableOption "Enable catppuccin desktop theming";

  config = lib.mkIf cfg.enable {
    themes.enable = true;

    stylix = {
      image = ../../../assets/wallpapers/catppuccin-mountain.jpg;

      base16Scheme =
        "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
    };
  };
}
