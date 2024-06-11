{ pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mod, Q, exec, ~/.local/bin/kill_window.sh"
      "$mod_SHIFT, Q, exit, "
      "$mod, F, togglefloating, "
      "$mod, P, pin, "
      "$mod, Space, centerwindow, "
      "$mod, 1, workspace, 1"
      "$mod_SHIFT, 1, movetoworkspacesilent, 1"
      "$mod, 2, workspace, 2"
      "$mod_SHIFT, 2, movetoworkspacesilent, 2"
      "$mod, 3, workspace, 3"
      "$mod_SHIFT, 3, movetoworkspacesilent, 3"
      "$mod, 4, workspace, 4"
      "$mod_SHIFT, 4, movetoworkspacesilent, 4"
      "$mod, 5, workspace, 5"
      "$mod_SHIFT, 5, movetoworkspacesilent, 5"
      "$mod, 6, workspace, 6"
      "$mod_SHIFT, 6, movetoworkspacesilent, 6"

      ", XF86Launch2, exec, "
      ", XF86Launch3, exec,"

      ", XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

      ", XF86Launch1, exec, rog-control-center"

      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioPlay, exec, playerctl play-pause"

      ", XF86Launch4, exec, asusctl profile -n"

      ", XF86KbdBrightnessDown, exec, asusctl -p"
      ", XF86KbdBrightnessUp, exec, asusctl -n"

      ", XF86TouchpadToggle, exec, hyprctl keyword \"device:elan1201:00-04f3:3098-touchpad:enabled\" false"
      "CTRL, XF86TouchpadToggle, exec, hyprctl keyword \"device:elan1201:00-04f3:3098-touchpad:enabled\" true"

      "$mod, Return, exec, alacritty"
      "$mod, E, exec, ${pkgs.gnome.nautilus}/bin/nautilus"
      "$mod, B, exec, ${pkgs.firefox}/bin/firefox"
      "$mod, C, exec, ${pkgs.vscode}/bin/code"
    ];

    binde = [
      "$mod, up, cyclenext, up"
      "$mod, left, cyclenext, left"
      "$mod, right, cyclenext, right"
      "$mod, down, cyclenext, down"
      "$mod_SHIFT, up, swapnext, up"
      "$mod_SHIFT, left, swapnext, left"
      "$mod_SHIFT, right, swapnext, right"
      "$mod_SHIFT, down, swapnext, down"

      ", XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

      ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set +10%"
      ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 10%-"
    ];

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
