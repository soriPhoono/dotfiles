{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.environments.noir;
in {
  config = lib.mkIf cfg.enable {
    desktop.programs.hyprland = {
      enable = true;

      environmentVariables = {
        NIXOS_OZONE_WL = "1";

        GDK_BACKEND = "wayland,x11,*";

        QT_QPA_PLATFORM = "wayland;xcb";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      };

      settings = {
        general = {
          border_size = 3;

          snap = {
            enabled = true;
            border_overlap = true;
          };
        };

        decoration = {
          rounding = 5;
          fullscreen_opacity = 1;
        };

        input = {
          repeat_rate = 20;
          repeat_delay = 300;

          accel_profile = "flat";
        };

        gestures = {
          workspace_swipe = true;
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
        };

        xwayland.force_zero_scaling = true;

        cursor.no_hardware_cursors = true;
      };

      animations = {
        curves = [
          "ease-in-out, .42, 0, .58, 1"
        ];

        animationRules = [
          "windows, 1, 5, ease-in-out, slide"
          "fade, 1, 5, ease-in-out"
        ];
      };
    };
  };
}
