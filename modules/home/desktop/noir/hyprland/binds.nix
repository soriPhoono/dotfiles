{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  options.desktop.noir = {
    modKey = lib.mkOption {
      type = lib.types.str;
      description = "The modifier key to enable hyprland hotkeys";

      default = "SUPER";
    };

    switchId = lib.mkOption {
      type = lib.types.str;
      description = "The id for the laptop switch if applicable";

      default = null;
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = let
      killScript = pkgs.writeShellApplication {
        name = "killscript.sh";

        runtimeInputs = with pkgs; [
          jq
          xdotool
        ];

        text = ''
          if [ "$(hyprctl activewindow -j | jq -r ".class")" = "Steam" ]; then
            xdotool getactivewindow windowunmap
          else
            hyprctl dispatch killactive ""
          fi
        '';
      };

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
      "$mod" = cfg.modKey;

      bind =
        [
          "$mod, Q, exec, ${killScript}/bin/killscript.sh"

          "$mod, F, togglefloating, "
          "$mod, P, pin, active"
          "$mod, C, centerwindow, "

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
        ]
        ++ (builtins.concatLists (builtins.genList (
            i: let
              directions = [
                "Up"
                "Left"
                "Right"
                "Down"
              ];

              key = builtins.elemAt directions i;
              direction = lib.toLower (lib.substring 0 1 key);

              resizeParams =
                if direction == "u"
                then "0 -10"
                else if direction == "l"
                then "-10 0"
                else if direction == "r"
                then "10 0"
                else "0 10";
            in [
              "$mod, ${key}, movefocus, ${direction}"
              "$mod CTRL, ${key}, movewindow, ${direction}"
              "$mod CTRL_SHIFT, ${key}, resizeactive, ${resizeParams}"
            ]
          )
          4))
        ++ (
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, ${toString ws}, workspace, ${toString ws}"
                "$mod SHIFT, ${toString ws}, movetoworkspacesilent, ${toString ws}"
              ]
            )
            9)
        );

      binde = [
        ", XF86AudioLowerVolume, exec, ${audio}/bin/audio.sh down"
        ", XF86AudioRaiseVolume, exec, ${audio}/bin/audio.sh up"

        ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 10%+"
        ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 10%-"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, Control_L, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod, ALT_L, resizewindow"
      ];
    };
  };
}
