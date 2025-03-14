{lib, ...}: {
  desktop = {
    environments.noir.enable = true;

    services.hypridle.enable = lib.mkForce false;
  };

  userapps = {
    enable = true;
    artwork.enable = true;
    development.enable = true;
    streaming.enable = true;
  };

  wayland.windowManager.hyprland.settings = {
    env = [
      "AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card2"
    ];

    monitor = [
      "DP-4, 1920x1080@165, 0x0, 1"
      "DP-5, 1920x1080@144, 1920x0, 1"
      "HDMI-A-5, 1920x1080@75, 3840x0, 1"
    ];

    workspace =
      (let
        monitors = [
          "DP-5"
          "HDMI-A-5"
          "DP-4"
        ];
      in
        map (
          x: "${builtins.toString (x + 1)}, monitor:${builtins.elemAt monitors (builtins.floor (x / 3))}"
        ) (builtins.genList (x: x) 9))
      ++ [
        "1, default:true"
        "4, default:true"
        "7, default:true"
      ];
  };
}
