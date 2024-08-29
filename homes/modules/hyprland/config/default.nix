{
  wayland.windowManager.hyprland.settings = {
    general = {
      border_size = 3;
      resize_on_border = true;
    };

    decoration = {
      rounding = 10;

      active_opacity = 0.8;
      inactive_opacity = 0.8;
      fullscreen_opacity = 0.8;

      shadow_range = 8;
    };

    input = {
      repeat_rate = 20;
      repeat_delay = 300;

      accel_profile = "flat";

      touchpad = {
        natural_scroll = true;

        clickfinger_behavior = true;
        tap-to-click = true;
        drag_lock = true;
        tap-and-drag = true;
      };
    };

    gestures = {
      workspace_swipe = true;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;

      vrr = 1;

      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;

      animate_manual_resizes = true;
      animate_mouse_windowdragging = true;
    };

    xwayland = {
      force_zero_scaling = true;
    };

    cursor = {
      no_hardware_cursors = true;
    };
  };
}
