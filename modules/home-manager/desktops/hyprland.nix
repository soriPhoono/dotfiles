{ pkgs, ... }: {
  home.packages = with pkgs; [
    # System
    dconf
    polkit_gnome
    libgnome-keyring
    libnotify
    # Visuals
    gammastep # Monitor brightness
    wlsunset # Nightcolor
    # Clipboard
    wl-clipboard
    cliphist
    # Applications
    gnome.nautilus
    gnome.file-roller
  ];

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];

    configPackages = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";

      monitor = [
        "eDP-1,1920x1080@144,0x0,1.5,vrr,1"
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

      exec-once = [
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      exec = [

      ];

      bind = [
        "$mod, Q, killactive, "
        "$mod_SHIFT, Q, exit, "

        "$mod, Return, exec, alacritty"
        "$mod, E, exec, nautilus"
        "$mod, B, exec, firefox"
      ] ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
            ]
          )
            10)
        );

      binde = [
        ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioPlay, exec, playerctl play-pause"

        ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
      ];

      bindl = [
        # TODO: lookup devices and create switch to disable monitor if lid is closed
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

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
