{ pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mod, Q, exec, ~/.local/bin/kill_window.sh"
      "$mod_SHIFT, Q, exit, "
      "$mod, F, togglefloating, "
      "$mod, P, pin, "
      "$mod, Space, centerwindow, "

      "$mod, Return, exec, alacritty"
      "$mod, E, exec, ${pkgs.gnome.nautilus}/bin/nautilus"
      "$mod, B, exec, ${pkgs.firefox}/bin/firefox"
      "$mod, C, exec, ${pkgs.vscode}/bin/code"
    ] ++ (
      # workspaces
      # binds $mod + [shift +] {1..6} to [move to] workspace {1..6}
      builtins.concatLists (builtins.genList
        (
          x:
          let
            ws =
              let
                c = (x + 1) / 6;
              in
              builtins.toString (x + 1 - (c * 6));
          in
          [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
          ]
        ) 10)
    );

    binde = [
      "$mod, up, cyclenext, up"
      "$mod, left, cyclenext, left"
      "$mod, right, cyclenext, right"
      "$mod, down, cyclenext, down"
      "$mod_SHIFT, up, swapnext, up"
      "$mod_SHIFT, left, swapnext, left"
      "$mod_SHIFT, right, swapnext, right"
      "$mod_SHIFT, down, swapnext, down"

      ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
      ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
      ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioPlay, exec, playerctl play-pause"

      ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
      ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
    ];

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
