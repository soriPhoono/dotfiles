{ ... }: {
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1,1920x1080@144,0x0,1,vrr,2"
    ];

    input = {
      kb_layout = "us";
      repeat_delay = 400;
      sensitivity = 0.1;
      accel_profile = "flat";
      touchpad = {
        natural_scroll = true;
        disable_while_typing = true;
        clickfinger_behavior = true;
      };
    };

    env = [
      "GBM_BACKEND = nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME = nvidia"
      "LIBVA_DRIVER_NAME = nvidia"
      "__GL_GSYNC_ALLOWED = 1"
      "__GL_VRR_ALLOWED = 0"
      "WLR_DRM_NO_ATOMIC = 1"
    ];

    bindl = [
      ", switch:on:2e65fb40, exec, loginctl lock-session && hyprctl keyword monitor \"eDP-1,disable\""
      ", switch:2e65fb40, exec, hyprctl keyword monitor \"eDP-1,1920x1080@144,0x0,1,vrr,2\""
    ];
  };
}
