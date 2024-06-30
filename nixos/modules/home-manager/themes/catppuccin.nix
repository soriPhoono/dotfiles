{ inputs, config, pkgs, vars, ... }:
let
  opacity = 0.8;

  default_font = 14;
  focus_font = 16;
  terminal_font = 16;
in {
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  stylix = {
    enable = true;

    targets = {
      nixvim.transparent_bg = {
        main = true;
        sign_column = true;
      };
    };

    image = vars.wallpaper_path;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    polarity = "dark";

    cursor = {
      package = pkgs.catppuccin-cursors.mochaTeal;
      size = 24;
      name = "Catppuccin-Mocha-Teal-Cursors";
    };

    opacity = {
      applications = opacity;
      desktop = opacity;
      popups = opacity;
      terminal = opacity;
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
        terminal = terminal_font;
      };
    };
  };
}
