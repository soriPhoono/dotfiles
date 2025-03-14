{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.environments.noir;
in {
  config = lib.mkIf cfg.enable {
    desktop.programs.hyprland = {
      enable = true;

      environmentVariables = {
        NIXOS_OZONE_WL = "1";

        GDK_BACKEND = "wayland,x11,*";

        QT_QPA_PLATFORM = "wayland;xcb";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      };

      autostart = let
        bootstrap = pkgs.writeShellApplication {
          name = "bootstrap.sh";

          runtimeInputs = with pkgs; [
            wl-clipboard-rs
            wl-clip-persist

            swww
          ];

          text = ''
            systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP
            dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=hyprland

            wl-clip-persist --clipboard both &

            swww-daemon --format xrgb &

            bitwarden --ozone-platform-hint=auto
          '';
        };
      in [
        "${bootstrap}/bin/bootstrap.sh"
      ];

      onReload = let
        reload = pkgs.writeShellApplication {
          name = "reload.sh";

          runtimeInputs = with pkgs; [
            libnotify

            swww
          ];

          text =
            # Bash
            ''
              if [[ -d ~/Pictures/Wallpapers ]];
              then
                sleep 0.5

                swww restore
              else
                notify-send "Failed to find wallpapers directory"
              fi
            '';
        };
      in [
        "${reload}/bin/reload.sh &"
      ];

      settings = {
        general = {
          border_size = 3;

          snap = {
            enabled = true;
            border_overlap = true;
          };
        };

        decoration.rounding = 5;

        input = {
          repeat_rate = 20;
          repeat_delay = 300;

          accel_profile = "flat";
        };

        gestures = {
          workspace_swipe = true;
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
        };

        xwayland.force_zero_scaling = true;

        cursor.no_hardware_cursors = true;
      };

      binds = let
        screenshot = pkgs.writeShellApplication {
          name = "screenshot.sh";

          runtimeInputs = with pkgs; [
            grimblast
            swappy
          ];

          text =
            # Bash
            ''
              swpy_dir="$HOME/.config/swappy"
              save_dir="$HOME/Pictures/Screenshots"
              save_file=$(date +'%y%m%d_%Hh%Mm%Ss_screenshot.png')
              temp_screenshot="/tmp/screenshot.png"

              mkdir -p "$save_dir"
              mkdir -p "$swpy_dir"
              echo -e "[Default]\nsave_dir=$save_dir\nsave_filename_format=$save_file" > "$swpy_dir/config"

              case "$1" in
              p)
                grimblast copysave screen $temp_screenshot && swappy -f $temp_screenshot ;;
              s)
                grimblast --freeze copysave area $temp_screenshot && swappy -f $temp_screenshot ;;
              m)
                grimblast copysave output $temp_screenshot && swappy -f $temp_screenshot ;;
              *)
                cat <<< "
                  ./screenshot.sh <action>
                  ...valid actions are...
                    p : print all screens
                    s : snip current screen (frozen)
                    m : print focused monitor
                " ;;
              esac

              rm "$temp_screenshot"

              if [ -f "$save_dir/$save_file" ]; then
                notify-send -a "Screenshot" -i "$save_dir/$save_file" -t 2200 "Screenshot saved" "saved at $save_dir/$save_file"
              fi
            '';
        };

        audio = pkgs.writeShellApplication {
          name = "audio.sh";

          runtimeInputs = with pkgs; [
            bc

            wireplumber
            playerctl
          ];

          text =
            # Bash
            ''
              case "$1" in
              up)
                if [[ "$(echo "$(wpctl get-volume @DEFAULT_SINK@ | awk '{ print $2 }') <= 0.95" | bc)" == "1" ]]; then
                  wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
                fi
                ;;
              down)
                wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
                ;;
              mute)
                wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
                ;;
              micmute)
                wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
                ;;
              playpause)
                playerctl play-pause
                ;;
              next)
                playerctl next
                ;;
              previous)
                playerctl previous
                ;;
              *)
                cat <<< "
                  ./volume.sh <action>
                  ...valid actions are...
                    up : raise volume up
                    down : lower volume down
                    mute : toggle mute
                    micmute : toggle mic mute
                    playpause : toggle play/pause
                    next : play next track
                    previous : play previous track
                " ;;
              esac
            '';
        };
      in {
        modKey = "SUPER";

        extraBinds = [
          "$mod, L, exec, ${pkgs.hyprlock}/bin/hyprlock"
          "$mod, A, exec, ${pkgs.fuzzel}/bin/fuzzel"
          "$mod, E, exec, ${pkgs.nautilus}/bin/nautilus"

          "$mod, Return, exec, ${pkgs.ghostty}/bin/ghostty"

          ", XF86AudioMute, exec, ${audio}/bin/audio.sh mute"
          ", XF86AudioMicMute, exec, ${audio}/bin/audio.sh micmute"

          ", XF86AudioNext, exec, ${audio}/bin/audio next"
          ", XF86AudioPrev, exec, ${audio}/bin/audio previous"
          ", XF86AudioPlay, exec, ${audio}/bin/audio playpause"

          ", Print, exec, ${screenshot}/bin/screenshot.sh s"
          "CTRL, Print, exec, ${screenshot}/bin/screenshot.sh m"
          "ALT, Print, exec, ${screenshot}/bin/screenshot.sh p"
        ];

        extraBindsE = [
          ", XF86AudioLowerVolume, exec, ${audio}/bin/audio.sh down"
          ", XF86AudioRaiseVolume, exec, ${audio}/bin/audio.sh up"

          ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 10%+"
          ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 10%-"
        ];
      };

      animations = {
        curves = [
          "ease-in-out, .42, 0, .58, 1"
        ];

        animationRules = [
          "windows, 1, 5, ease-in-out, slide"
          "fade, 1, 5, ease-in-out"
        ];
      };

      windowRules = [
        # Opacity
        "opacity 0.8, class:(.*)"

        "opacity 1, title:(.* - YouTube —.*)"

        "float,class:^(nm-applet)$"
        "size 80% 80%, class:^(nm-applet)$"
        "center, class:^(nm-applet)$"

        "float,class:^(nm-connection-editor)$"
        "size 80% 80%, class:^(nm-connection-editor)$"
        "center, class:^(nm-connection-editor)$"

        "float,class:^(pavucontrol)$"
        "size 80% 80%, class:^(pavucontrol)$"
        "center, class:^(pavucontrol)$"

        "float,class:^(blueberry.py)$"
        "size, class:^(blueberry.py)$"
        "center, class:^(blueberry.py)$"

        "opacity 1, class:(gamescope)"
        "float, class:(gamescope)"
        "workspace 1, class:(gamescope)"
      ];
    };
  };
}
