{ lib, pkgs, config, ... }:
let
  cfg = config.desktop.regreet;

  hyprland_config = pkgs.writeTextFile
    {
      name = "hyprland.conf";

      text = ''
        exec-once = ${pkgs.greetd.regreet}/bin/regreet
      '';
    };
in
{
  options = {
    desktop.regreet.enable =
      lib.mkEnableOption "Enable regreet display manager";
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;

      settings = {
        default_session = {
          command = "${pkgs.hyprland}/bin/Hyprland --config ${hyprland_config}";
        };
      };
    };

    programs.regreet = {
      enable = true;

      cursorTheme = {
        package = pkgs.catppuccin-cursors.mochaTeal;
        name = "catppuccin-mocha-teal-cursors";
      };

      font = {
        package = pkgs.nerdfonts;
        name = "AurulentSansM Nerd Font Propo";
      };

      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };

      theme = {
        package = pkgs.catppuccin-gtk.overrideAttrs {
          accents = "teal";
          variant = "mocha";
        };
        name = "catppuccin-mocha-teal-standard+default";
      };

      settings = {
        background = {
          path = ../../../assets/catppuccin-mountain.jpg;
          fit = "Contain";
        };

        GTK = {
          application_prefer_dark_theme = true;
        };
      };
    };
  };
}
