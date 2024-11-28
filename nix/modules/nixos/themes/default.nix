{ lib, pkgs, config, ... }:
let cfg = config.themes;
in{
  imports = [
    ./catppuccin.nix
  ];

  options.themes.enable =
    lib.mkEnableOption "Enable themes system";

  config.stylix = lib.mkIf cfg.enable
   {
      enable = true;

      cursor = {
        package = pkgs.bibata-cursors-translucent;
        size = 24;
        name = "Bibata_Ghost";
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
}
