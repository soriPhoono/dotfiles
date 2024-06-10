{ ... }: {
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "opacity .8, class:(.*)"
    ];

    layerrule = [
      "blur, *"
      "blurpopups, *"
    ];
  };
}
