{ config, pkgs, ... }:
let
  opacity = .8;

  default_font = 14;
  focus_font = 16;
in {
  stylix = {
    opacity = {
      applications = opacity;
      desktop = opacity;
      popups = opacity;
      terminal = opacity;
    };

    image = ../../assets/wallpaper.png;

    base16Scheme = pkgs.fetchFromGitHub {
      owner = "tinted-theming";
      repo = "base16-schemes";
      rev = "2b6f2d0677216ddda50c9cabd6ee70fae4665f81";
      sha256 = "VTczZi1C4WSzejpTFbneMonAdarRLtDnFehVxWs6ad0=";
    } + "/catppuccin-mocha.yaml";

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