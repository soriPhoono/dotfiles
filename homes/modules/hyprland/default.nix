{ lib
, ...
}: {
  imports = [
    ../desktop

    ./config
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    systemd.variables = [ "--all" ];
  };
}
