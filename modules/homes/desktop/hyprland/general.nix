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

      shadow_range = 8;
    };

    input = {
      repeat_rate = 30;
      repeat_delay = 200;

      accel_profile = "flat";

      touchpad = {
        natural_scroll = true;

        clickfinger_behavior = true;
        tap-to-click = true;
        drag_lock = true;
      };
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_cancel_ratio = 0.3;
      workspace_swipe_create_new = false;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;

      vrr = 1;

      mouse_move_enables_dpms = true;
    };

    xwayland = { force_zero_scaling = true; };

    cursor = { no_hardware_cursors = true; };
  };
}
