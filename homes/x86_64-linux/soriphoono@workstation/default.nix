{
  desktop.noir.enable = true;

  userapps.enable = true;

  wayland.windowManager.hyprland.settings = {
    env = [
      "AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card2"
    ];

    monitor = [
      "DP-4, 1920x1080@165, 0x0, 1"
      "DP-5, 1920x1080@144, 1920x0, 1"
      "HDMI-A-5, 1920x1080@75, 3840x0, 1"
    ];
  };
}
