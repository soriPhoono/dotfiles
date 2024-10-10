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
        # env = [
        #   "AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1"
        # ];
        
        monitor = [ 
          "HDMI-A-1,1920x1080@75,0x0,1"
          "DP-4,1920x1080@144,1920x0,1"
          "DP-1,1920x1080@165,3840x0,1"
        ];
      };
    };
  };

  userapps.enable = true;
  userapps.gaming.enable = true;
  userapps.office.enable = true;
  userapps.development.enable = true;

  themes.catppuccin.enable = true;
}
