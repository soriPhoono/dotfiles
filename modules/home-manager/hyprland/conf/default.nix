{ ... }: {
  imports = [
    ./hypridle.nix
    ./hyprlock.nix

    ./binds.nix
    ./rules.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";

      env = [
        "XCURSOR_SIZE = 32"

        "NIXOS_OZONE_WL = 1"

        "GDK_BACKEND = wayland,x11,*"
        "SDL_VIDEODRIVER = wayland"
        "CLUTTER_BACKEND = wayland"

        "QT_AUTO_SCREEN_SCALE_FACTOR = 1"
        "QT_QPA_PLATFORM = wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION = 1"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 15;
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
        bezier = [
          "myBezier, 0, 0, 0, 1"
        ];
        animation = [
          "windowsIn, 1, 4, myBezier, slide"
          "fadeIn, 1, 4, myBezier"
          "windowsOut, 1, 2, myBezier, popin 80%"
          "fadeOut, 1, 2, myBezier"
          "windowsMove, 1, 8, myBezier, slide"

          "workspaces, 1, 2, myBezier, slidefade 30%"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      exec-once = [
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"

        "swww-daemon & sleep 0.1 && swww img ~/Pictures/wallpapers/2.jpg"
      ];

      exec = [

      ];

      gestures.workspace_swipe = true;
      master.new_is_master = true;
      misc.disable_hyprland_logo = true;
      opengl.nvidia_anti_flicker = true;
      xwayland.force_zero_scaling = true;
    };
  };
}
