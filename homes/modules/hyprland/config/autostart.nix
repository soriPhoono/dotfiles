{ pkgs
, ...
}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = with pkgs; [
      "${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent"
    ];

    exec = [
      "pidof waybar || waybar &"
    ];
  };
}