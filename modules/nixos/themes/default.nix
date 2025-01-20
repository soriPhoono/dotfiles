{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.system.themes;
in {
  imports = [
    ./catppuccin.nix
  ];

  options.system.themes.enable = lib.mkEnableOption "Enable themes system";

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;

      cursor = {
        package = pkgs.bibata-cursors-translucent;
        size = 24;
        name = "Bibata_Ghost";
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

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        sizes = let
          default = 14;
          focused = 16;
        in {
          applications = focused;
          desktop = focused;
          popups = default;
          terminal = focused;
        };
      };
    };
  };
}
