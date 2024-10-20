{ pkgs, ... }: {
  imports = [ ./common.nix ];

  home.packages = with pkgs; [
    nexusmods-app-unfree
  ];

  desktop = {
    hyprland = {
      enable = true;
      extraSettings = {
        env = [ "AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card2" ];

        monitor = [
          "HDMI-A-5,1920x1080@75,0x0,1"
          "DP-4,1920x1080@144,1920x0,1"
          "DP-5,1920x1080@165,3840x0,1"
          "HDMI-A-1,1920x1080,3840x0,1,mirror,DP-5"
        ]; # TODO: fix cabling

        # Bind each workspace to each monitor
        workspace =
          builtins.map (x: "${builtins.toString x}, " + "monitor:DP-4") [
            1
            4
            7
          ] ++ builtins.map (x: "${builtins.toString x}, " + "monitor:DP-5") [
            2
            5
            8
          ]
          ++ builtins.map (x: "${builtins.toString x}, " + "monitor:HDMI-A-5") [
            3
            6
            9
          ];
      };
    };
  };

  userapps.streaming.enable = true;
}
