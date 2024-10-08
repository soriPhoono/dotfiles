{
  wayland.windowManager.hyprland.settings = {
    bezier = [
      "easeInOut, 0.65, 0, 0.35, 1"
      "easeIn, 0.32, 0, 0.67, 0"
      "easeOut, 0.33, 1, 0.68, 1"
    ];

    animation = [
      "windowsIn, 1, 4, easeOut, "
      "windowsOut, 1, 4, easeIn, "
      "windowsMove, 1, 4, easeOut, "

      "fade, 1, 4, easeInOut, "

      "workspaces, 1, 4, easeInOut, "
    ];

    windowrulev2 = [
      "float, class:(thunar)"
      "center, class:(thunar)"
      "size 80%, class:(thunar)"

      "float, class:(gnome-disks)"
      "center, class:(gnome-disks)"
      "size 80%, class:(gnome-disks)"
    
      "float, class:(steam), title:(Friends List)"
      "center, class:(steam), title:(Friends List)"
      "size 80%, class:(steam), title:(Friends List)"
    ];
  };
}
