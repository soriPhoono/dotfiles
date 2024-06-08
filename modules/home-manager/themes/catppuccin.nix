{ inputs, config, pkgs, ... }:
let
  opacity = .8;

  default_font = 14;
  focus_font = 16;
in {
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  stylix = {
    opacity = {
      applications = opacity;
      desktop = opacity;
      popups = opacity;
      terminal = opacity;
    };

    image = ../../assets/wallpaper.png;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    fonts = {
      serif = {
        package = pkgs.nerdfonts;
        name = "AurulentSansM Nerd Font Propo";
      };

      sansSerif = config.stylix.fonts.serif;

      monospace = {
        package = pkgs.nerdfonts;
        name = "JetBrainsMono Nerd Font Mono";
      };

      sizes = {
        applications = focus_font;
        desktop = default_font;
        popups = default_font;
        terminal = focus_font;
      };
    };

    cursor = {
      package = pkgs.catppuccin-cursors.override;
      size = 64;
      name = "catppuccin-teal-mocha";
    };
  };
}