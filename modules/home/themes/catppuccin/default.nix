{ lib
, pkgs
, config
, ...
}:
let
  cfg = config.themes.catppuccin;
in
{
  options = {
    themes.catppuccin.enable = lib.mkEnableOption "Home Catppuccin Theme";
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;

      targets = {
        nixvim.transparent_bg = {
          main = true;
          sign_column = true;
        };
      };

      image = ../../../../assets/wallpapers/cutie_dino.png;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

      cursor = {
        package = pkgs.catppuccin-cursors.mochaTeal;
        size = 24;
        name = "catppuccin-mocha-teal-cursors";
      };

      fonts = {
        serif = {
          package = pkgs.nerdfonts;
          name = "AurulentSansM Nerd Font Propo";
        };

        sansSerif = {
          package = pkgs.nerdfonts;
          name = "AurulentSansM Nerd Font Propo";
        };

        monospace = {
          package = pkgs.nerdfonts;
          name = "JetBrainsMono Nerd Font Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        sizes =
          let
            default_font = 14;
            focus_font = 16;
          in
          {
            applications = focus_font;
            desktop = focus_font;
            popups = default_font;
            terminal = focus_font;
          };
      };
    };
  };
}
