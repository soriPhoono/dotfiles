{ lib, pkgs, config, nixosConfig, ... }:
let cfg = config.themes.catppuccin;
in {
  options = {
    themes.catppuccin.enable =
      lib.mkEnableOption "Enable catppuccin desktop theming";
  };

  config = lib.mkIf cfg.enable {
    themes.enable = true;

    stylix = {
      image = nixosConfig.desktop.wallpaper;

      base16Scheme =
        "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    };
  };
}
