let
  floatingWindows = [
    # TODO: add more floating window rules for hyprland
    # Disk manager
    "class:(gnome-disks)"
    # Feh image viewer
    "class:(feh)"
    # Mpv video player
    "class:(mpv)"
    # Nautilus
    "class:(org.gnome.Nautilus)"
    "class:(org.gnome.FileRoller)"
    # Discord
    "class:(discord)"
    # Steam
    "class:(steam), title:(steam)"
    # Onlyoffice
    "class:(ONLYOFFICE Desktop Editors)"
    # VsCode
    "class:(code), title:(Open Folder)"
    # Obsidian
    "class:(electron), title:(Open folder as vault)"
  ];
in
{
  wayland.windowManager.hyprland.settings = {
    bezier = [
      "easeInOut, 0.65, 0, 0.35, 1"
      "easeIn, 0.32, 0, 0.67, 0"
      "easeOut, 0.33, 1, 0.68, 1"
    ];

    animation = [
      "windows, 1, 4, easeIn, popin 50%"
      "windowsMove, 1, 4, easeOut, "

      "workspaces, 1, 4, easeInOut, "
    ];

    windowrulev2 = builtins.concatMap
      (v: [ "float, ${v}" ] ++ [ "center, ${v}" ] ++ [ "size 80%, ${v}" ])
      floatingWindows
    ++ [
      "opacity 0.8, class:(.*)"

      "opacity 1, class:(factorio)"
      "opacity 1, class:(gamescope)"
      "opacity 1, class:(firefox) title:(.*)( - YouTube)(.*)"

      "workspace 1, class:(gamescope)"
      "float, class:(gamescope)"
    ];
  };
}
