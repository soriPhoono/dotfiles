{ lib, pkgs, config, ... }:
let cfg = config.desktop.hyprland;
in {
  options = {
    desktop.hyprland.enable = lib.mkEnableOption "Enable Hyprland desktop module";
  };

  config = lib.mkIf cfg.enable {
    desktop.enable = true;

    programs = {
      alacritty = {
        enable = true;

        settings.cursor.style = "Beam";
      };

      wlogout = {
        enable = true;
      };
    };

    services.mako = {
      enable = true;

      anchor = "top-right";
      margin = "20,20,5";

      borderRadius = 10;
      borderSize = 3;

      defaultTimeout = 3000;

      maxVisible = 3;

      height = 180;
      width = 320;

      iconPath = "${pkgs.papirus-icon-theme}/usr/share/icons";
    };

    wayland.windowManager.hyprland = {
      enable = true;

      systemd.variables = [ "--all" ];

      settings = {
        "$mod" = "SUPER";

        general = {
          border_size = 3;
          resize_on_border = true;
        };

        decoration = {
          rounding = 10;

          shadow.range = 8;
        };

        input = {
          repeat_rate = 30;
          repeat_delay = 200;

          accel_profile = "flat";
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_cancel_ratio = 0.3;
          workspace_swipe_create_new = false;
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;

          vrr = 1;

          mouse_move_enables_dpms = true;

          animate_manual_resizes = true;
          animate_mouse_windowdragging = true;
        };

        xwayland.force_zero_scaling = true;

        cursor.no_hardware_cursors = true;

        bezier = [
          "easeInOut, 0.65, 0, 0.35, 1"
          "easeIn, 0.32, 0, 0.67, 0"
          "easeOut, 0.33, 1, 0.68, 1"
        ];

        animation = [
          "windows, 1, 4, easeIn, popin 50%"
          "windowsMove, 1, 4, easeOut, "

          "workspaces, 1, 4, easeInOut, "
        ];

        windowrulev2 =
          let
            floatingWindows = [
              # TODO: add more floating window rules for hyprland
              # Disk manager
              "class:(gnome-disks)"
              # Feh image viewer
              "class:(feh)"
              # Mpv video player
              "class:(mpv)"
              # Nautilus
              "class:(org.gnome.Nautilus)"
              "class:(org.gnome.FileRoller)"
              # Discord
              "class:(discord)"
              # Steam
              "class:(steam), title:(steam)"
              # VsCode
              "class:(code), title:(Open Folder)"
              # Obsidian
              "class:(electron), title:(Open folder as vault)"
            ];
          in
          builtins.concatMap
            (v: [ "float, ${v}" ] ++ [ "center, ${v}" ] ++ [ "size 80%, ${v}" ])
            floatingWindows
          ++ [
            "opacity 0.8, class:(.*)"

            "opacity 1, class:(firefox), title:(.*)( - YouTube)(.*)"

            "workspace 1, class:(gamescope)"
            "opacity 1, class:(gamescope)"
            "float, class:(gamescope)"
          ];

        bind = [
          "$mod, Q, killactive,"

          "$mod, F, togglefloating,"
          "$mod, P, pin,"
          "$mod, C, centerwindow, 1"

          "$mod, up, movefocus, u"
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, down, movefocus, d"

          "$mod SHIFT, up, swapwindow, u"
          "$mod SHIFT, left, swapwindow, l"
          "$mod SHIFT, right, swapwindow, r"
          "$mod SHIFT, down, swapwindow, d"

          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"

          ", PRINT, exec, grim ~/Pictures/screenshot-$(date +%Y%m%d%H%M).png"
          ''
            $mod, PRINT, exec, grim -g "$(slurp)" ~/Pictures/screenshot-$(date +%Y%m%d%H%M).png''
          ''
            $mod CTRL, PRINT, exec, grim -g "$(slurp)" - | wl-copy''

          "$mod, Return, exec, alacritty"
          "$mod, E, exec, thunar"
          "$mod, B, exec, firefox"
          "$mod, C, exec, code"
          "$mod, N, exec, obsidian"
        ] ++ (builtins.concatLists (builtins.genList
          (x:
            let ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]) 10));

        binde = [
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ \"$value%-\""
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ \"$value%+\""

          ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ];

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"

          "$mod, Control_L, movewindow"
          "$mod, ALT_L, resizewindow"
        ];
      };
    };
  };
}
