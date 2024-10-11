{
  core = {
    shells.fish.enable = true;

    programs = {
      git = {
        userName = "soriphoono";
        userEmail = "soriphoono@gmail.com";
      };
    };
  };

  desktop = {
    hyprland = {
      enable = true;
      extraSettings = {
        env = [ "AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card2" ];

        monitor = [
          "HDMI-A-1,1920x1080@75,0x0,1"
          "DP-4,1920x1080@144,1920x0,1"
          "DP-1,1920x1080@165,3840x0,1"
        ];

        # Bind each workspace to each monitor
        workspace =
          builtins.map (x: "${builtins.toString x}, " + "monitor:DP-4") [
            1
            4
            7
          ] ++ builtins.map (x: "${builtins.toString x}, " + "monitor:DP-1") [
            2
            5
            8
          ]
          ++ builtins.map (x: "${builtins.toString x}, " + "monitor:HDMI-A-1") [
            3
            6
            9
          ];
      };
    };
  };

  userapps.enable = true;
  userapps.office.enable = true;
  userapps.development.enable = true;

  themes.catppuccin.enable = true;
}
