{ lib, pkgs, config, ... }:
let cfg = config.desktop.hyprland;
in
{
  options = {
    desktop.hyprland = {
      enable = lib.mkEnableOption "Enable hyprland window manager";

      monitors = lib.mkOption {
        type = lib.types.listOf lib.lines.str;
        default = [

        ];
        description = ''
          List of monitors and their configuration lines.
          Used by hyprland in greetd and nowhere else, 
          but required for system level config of login system.
        '';
        example = [
          "eDP-1, 1920x1080@144, 0x0, 1"
        ];
      };
    };
  };

  config = lib.mkIf cfg.enable {
    desktop.enable = true;

    environment.systemPackages = with pkgs; [
      kitty
    ];

    programs = {
      hyprland.enable = true;

      regreet = {
        enable = true;

        theme = {
          package = (pkgs.magnetic-catppuccin-gtk.override {
            # accent = [ "teal" ];
            # tweaks = [
            #   "black"
            #   "float"
            #   "outline"
            # ];
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

        settings.background.path = ../../../assets/wallpapers/catppuccin-mountain.jpg;
      };
    };

    services = {
      greetd = {
        enable = true;

        vt = 1;

        settings = {
          default_session = {
            command = let 
              hypr_config = ''
                ${builtins.map (monitor: "monitor = ${monitor}") cfg.monitors}

                input = {
                  repeat_rate = 30;
                  repeat_delay = 200;
                  accel_profile = "flat";
                }

                misc = {
                  disable_hyprland_logo = true;
                  disable_splash_rendering = true;

                  mouse_move_enables_dpms = true;
                  key_press_enables_dpms = true;
                }

                exec = ${pkgs.greetd.regreet}/bin/regreet; hyprctl dispatch exit
              '';
            in "${pkgs.hyprland}/bin/Hyprland --config ${hypr_config}";
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
