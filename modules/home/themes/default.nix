{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.themes;
in
  with lib; {
    imports = [
      ./catppuccin.nix
    ];

    options.themes = {
      enable = mkEnableOption "Enable the default theme configuration.";
      background = mkOption {
        type = lib.types.path;
        default = ../../../assets/wallpapers/japanese_sun.png;
        description = "Path to the background image.";
      };
      cursor = {
        name = mkOption {
          type = lib.types.str;
          default = "Bibata-Modern-Ice";
          description = "Name of the cursor theme.";
        };
        package = mkOption {
          type = lib.types.package;
          default = pkgs.bibata-cursors;
          description = "Package providing the cursor theme.";
        };
        size = mkOption {
          type = lib.types.int;
          default = 24;
          description = "Size of the cursor.";
        };
      };
      iconTheme = {
        dark = mkOption {
          type = lib.types.str;
          default = "Papirus-Dark";
          description = "Name of the dark icon theme.";
        };
        light = mkOption {
          type = lib.types.str;
          default = "Papirus";
          description = "Name of the light icon theme.";
        };
        package = mkOption {
          type = lib.types.package;
          default = pkgs.papirus-icon-theme;
          description = "Package providing the icon themes.";
        };
      };
    };

    config = mkIf cfg.enable {
      stylix = {
        enable = true;

        image = cfg.background;

        cursor = {
          package = cfg.cursor.package;
          name = cfg.cursor.name;
          size = cfg.cursor.size;
        };

        iconTheme = {
          enable = true;
          package = cfg.iconTheme.package;
          dark = cfg.iconTheme.dark;
          light = cfg.iconTheme.light;
        };

        fonts = {
          serif = {
            package = pkgs.nerd-fonts.aurulent-sans-mono;
            name = "AurulentSansM Nerd Font Propo";
          };

          sansSerif = {
            package = pkgs.nerd-fonts.aurulent-sans-mono;
            name = "AurulentSansM Nerd Font Propo";
          };

          monospace = {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name = "JetBrainsMono Nerd Font Mono";
          };

          sizes = let
            default = 14;
          in {
            applications = default;
            desktop = default;
            popups = default;
            terminal = default;
          };
        };
      };
    };
  }
