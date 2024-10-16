{ pkgs, ... }:
let
  volumeScript = pkgs.writeShellApplication {
    name = "volume.sh";

    runtimeInputs = with pkgs; [ wireplumber libnotify ];

    text = ''
      #!/bin/bash

      operation=$1
      value=$2
      current=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ print $2 }')

      if [[ "$operation" = "raise" ]]; then
        if [[ $(awk "BEGIN { print $current * 100 + $value }") -gt 100 ]]; then
          exit 0
        fi

        wpctl set-volume @DEFAULT_AUDIO_SINK@ "$value%+"

      elif [[ "$operation" = "lower" ]]; then
        wpctl set-volume @DEFAULT_AUDIO_SINK@ "$value%-"
      fi

      current=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ print $2 }')
      notify-send Changed volume to "$current"  
    '';
  };

  # TODO: finish this
  brightnessScript = pkgs.writeShellApplication {
    name = "brightness.sh";

    runtimeInputs = with pkgs; [ brightnessctl libnotify ];

    text = ''
      #!/bin/bash

      operation=$1
      value=$2
      current=$(brightnessctl get)

      if [[ "$operation" = "raise" ]]; then
        if [[ $(awk "BEGIN { print $current * 100 + $value }") -gt 100 ]]; then
          exit 0
        fi

        wpctl set-volume @DEFAULT_AUDIO_SINK@ $value%+

      elif [[ "$operation" = "lower" ]]; then
        wpctl set-volume @DEFAULT_AUDIO_SINK@ $value%-
      fi

      current=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ print $2 }')
      notify-send Changed volume to "$current"
    '';
  };
in
{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bind = with pkgs;
      [
        "$mod SHIFT, Q, exit, "
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

        ", XF86AudioMute, exec, ${wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, ${wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

        ", XF86AudioPlay, exec, ${playerctl}/bin/playerctl play-pause"
        ", XF86AudioPrev, exec, ${playerctl}/bin/playerctl previous"
        ", XF86AudioNext, exec, ${playerctl}/bin/playerctl next"

        ", PRINT, exec, ${grim}/bin/grim ~/Pictures/screenshot-$(date +%Y%m%d%H%M).png"
        ''
          $mod, PRINT, exec, ${grim}/bin/grim -g "$(${slurp}/bin/slurp)" ~/Pictures/screenshot-$(date +%Y%m%d%H%M).png''
        ''
          $mod CTRL, PRINT, exec, ${grim}/bin/grim -g "$(${slurp}/bin/slurp)" - | ${wl-clipboard-rs}/bin/wl-copy''

        "$mod, RETURN, exec, ${alacritty}/bin/alacritty"
        "$mod, A, exec, ${fuzzel}/bin/fuzzel"
        "$mod, E, exec, ${nautilus}/bin/nautilus"
        "$mod, B, exec, ${firefox}/bin/firefox"
        "$mod, C, exec, ${vscode-fhs}/bin/code --ozone-platform-hint=auto"
        "$mod, N, exec, ${obsidian}/bin/obsidian --ozone-platform-hint=auto"
      ] ++ (builtins.concatLists (builtins.genList
        (x:
          let ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
          in [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]) 10));

    binde = with pkgs; [
      ", XF86AudioLowerVolume, exec, ${volumeScript}/bin/volume.sh lower 5"
      ", XF86AudioRaiseVolume, exec, ${volumeScript}/bin/volume.sh raise 5"

      ", XF86MonBrightnessDown, exec, ${brightnessctl}/bin/brightnessctl set 5%-"
      ", XF86MonBrightnessUp, exec, ${brightnessctl}/bin/brightnessctl set 5%+"
    ];

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"

      "$mod, Control_L, movewindow"
      "$mod, ALT_L, resizewindow"
    ];
  };
}
