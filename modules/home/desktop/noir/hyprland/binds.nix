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
    wayland.windowManager.hyprland.settings = {
      "$mod" = cfg.modKey;

      bind = let
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

          text = ''
            if [ -z "$XDG_PICTURES_DIR" ] ; then
              XDG_PICTURES_DIR="$HOME/Pictures"
            fi

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
      in
        [
          "$mod, Q, exec, ${killScript}/bin/killscript.sh"

          "$mod, F, togglefloating, "
          "$mod, P, pin, active"
          "$mod, C, centerwindow, "

          ", XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

          ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
          ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl prev"
          ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"

          "$mod, P, exec, ${screenshot}/bin/screenshot.sh s"
          "$mod CTRL, P, exec, ${screenshot}/bin/screenshot.sh m"
          "$mod ALT, P, exec, ${screenshot}/bin/screenshot.sh p"
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
        ", XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"

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
