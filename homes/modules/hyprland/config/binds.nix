{ pkgs
, ...
}: {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bind = with pkgs; [
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

      "$mod, RETURN, exec, ${alacritty}" # Terminal
      "$mod, B, exec, ${firefox}"
    ] ++ (
      builtins.concatLists (builtins.genList
        (
          x:
          let
            ws =
              let c = (x + 1) / 10;
              in builtins.toString (x + 1 - (c * 10));
          in
          [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]
        ) 10)
    );

    bindl = [
      ", switch:on:473c56e0, exec, hyprctl dispatch dpms off"
      ", switch:off:473c56e0, exec, hyprctl dispatch dpms on"
    ];

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"

      "$mod, Control_L, movewindow"
      "$mod, ALT_L, resizewindow"
    ];
  };
}
