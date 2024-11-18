{ lib, pkgs, config, ... }:
let cfg = config.desktop.hyprland;
in
{
  options = {
    desktop.hyprland = {
      enable = lib.mkEnableOption "Enable hyprland window manager";
    };
  };

  config = lib.mkIf cfg.enable {
    desktop.enable = true;

    programs = {
      hyprland.enable = true;

      regreet = {
        enable = true;

        theme = {
          package = (pkgs.magnetic-catppuccin-gtk.override {
            accent = ["teal"];
            tweaks = [
              "black"
              "float"
              "outline"
            ];
          });
          
          name = "magnetic-catppuccin-gtk";
        };

        font = {
          name = "AurulentSansM Nerd Font Propo";
          size = 14;
        };

        iconTheme = {
          package = pkgs.papirus-icon-theme;
          name = "Papirus-Dark";
        };

        cursorTheme = {
          package = pkgs.bibata-cursors-translucent;
          name = "Bibata_Ghost";
        };

        settings = {
          background.path = config.desktop.wallpaper;
        };
      };
    };

    services = {
      upower.enable = true;
      auto-cpufreq.enable = true;

      greetd = {
        enable = true;

        vt = 1;

        settings = {
          default_session =
            let
              greetd-hypr = pkgs.writeText "greetd-hypr.conf"
                ''
                  exec-once = regreet; hyprctl dispatch exit
                '';
            in
            {
              command = "${config.programs.hyprland.package}/bin/Hyprland --config ${greetd-hypr}";
              user = "greeter";
            };

          initial_session = {
            command = "Hyprland";
            user = "soriphoono";
          };
        };
      };
    };
  };
}
