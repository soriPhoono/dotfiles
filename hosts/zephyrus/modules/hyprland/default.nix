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
  };
}
