{ ... }: {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";

      monitor = [
        "eDP-1,1920x1080@144,0x0,1"
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

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 3;
        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        rounding = 7;
        drop_shadow = true;
        shadow_range = 4;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };

      animations = {
        enabled = 1;
        bezier = "overshot,0.13,0.99,0.29,1.1,";
        animation = [
          "fade,1,4,default"
          "workspaces,1,4,default,fade"
          "windows,1,4,overshot,popin 80%"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master.new_is_master = true;
      misc.disable_hyprland_logo = true;
      gestures.workspace_swipe = true;
      xwayland.force_zero_scaling = true;
      opengl.nvidia_anti_flicker = true;

      windowrulev2 = [
        "opacity .8, class:(.*)"
      ];

      layerrule = [
        "blur, *"
        "blurpopups, *"
      ];
    };
  };
}
