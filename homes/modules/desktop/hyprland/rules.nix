let
  floatingWindows = [
    "class:(thunar)"
    "class:(gnome-disks)"
    "class:(virt-manager), title:(Virtual Machine Manager)"
    "class:(ONLYOFFICE Desktop Editors)"
    "class:(steam)"
    "class:(discord)"
    "class:(code), title:(Open Folder)"
  ];
in {
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

    windowrulev2 = builtins.concatMap
      (v: [ "float, ${v}" ] ++ [ "center, ${v}" ] ++ [ "size 80%, ${v}" ])
      floatingWindows ++ [
      "workspace 1, class:(gamescope)"
    ];
  };
}
