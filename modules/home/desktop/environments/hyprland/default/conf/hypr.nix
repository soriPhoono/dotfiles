{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.environments.hyprland.default;
in
  with lib; {
    config = mkIf cfg.enable {
      wayland.windowManager.hyprland.settings = {
        general = {
          border_size = 3;
          gaps_out = 10;

          no_focus_fallback = true;
          resize_on_border = true;
          resize_corner = 3;

          snap.enabled = true;
        };

        decoration = {
          rounding = 10;
          rounding_power = 4.0;

          active_opacity = 0.8;
          inactive_opacity = 0.8;
          fullscreen_opacity = 1.0; # NOTE: This may need to be removed with manual opacity specifications in the layer config later
        };

        input = {
          repeat_rate = 20;
          repeat_delay = 300;
          accel_profile = "flat";

          touchpad = {
            clickfinger_behavior = true;
            drag_3fg = 1;
          };
        };

        misc = {
          disable_hyprland_logo = true;
          animate_manual_resizes = true;
          animate_mouse_windowdragging = true;
        };

        xwayland.force_zero_scaling = true;
      };
    };
  }
