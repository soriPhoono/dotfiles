{ pkgs
, ...
}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = with pkgs; [
      "${polkit_gnome}/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
    ];

    exec = [

    ];
  };
}
