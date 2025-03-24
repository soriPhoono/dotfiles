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
      "DP-1, 1920x1080@144, 0x0, 1, vrr, 1"
      "HDMI-A-1, 1920x1080@75, 1920x0, 1, vrr, 1"
    ];

    workspace =
      (let
        monitors = [
          "DP-1"
          "HDMI-A-1"
        ];
      in
        map (
          x: "${builtins.toString (x + 1)}, monitor:${builtins.elemAt monitors (builtins.floor (x / 3))}"
        ) (builtins.genList (x: x) 6))
      ++ [
        "1, default:true"
        "4, default:true"
      ];
  };
}
