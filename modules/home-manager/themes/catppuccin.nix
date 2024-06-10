{ inputs, config, pkgs, ... }:
let
  opacity = .8;

  default_font = 14;
  focus_font = 15;
in
{
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

    image = ../../../assets/wallpapers/1.png;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    cursor = {
      package = pkgs.catppuccin-cursors.mochaTeal;
      size = 64;
      name = "Catppuccin-Mocha-Teal-Cursors";
    };

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

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = focus_font;
        desktop = default_font;
        popups = default_font;
        terminal = focus_font;
      };
    };
  };

  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = "Papirus-Dark";
  };
}
