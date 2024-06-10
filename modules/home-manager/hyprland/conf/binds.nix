{ ... }: {
  wayland.windowManager.hyprland.settings = {
  bind = [
    "$mod, Q, killactive, "
    "$mod_SHIFT, Q, exit, "

    "$mod, Return, exec, alacritty"
    "$mod, E, exec, nautilus"
    "$mod, B, exec, firefox"
    "$mod, C, exec, code --enable-features=UseOzonePlatform --ozone-platform=wayland"
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
    ) 10)
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
  };
}
