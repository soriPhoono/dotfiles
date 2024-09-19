{ lib
, pkgs
, ...
}: {
  imports = [
    ../desktop
    ./supporting.nix
    
    ./config
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    systemd.variables = [ "--all" ];

    settings.env = [
      "XDG_SESSION_DESKTOP,Hyprland"

      "HYPRCURSOR_SIZE,24"
      "XCURSOR_SIZE,24"

      "GDK_BACKEND,wayland,x11,*"
      "QT_QPA_PLATFORM,wayland;xcb"
      "SDL_VIDEODRIVER,wayland"
      "CLUTTER_BACKEND,wayland"

      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
    ];
  };
}
