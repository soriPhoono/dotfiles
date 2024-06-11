{ ... }: {
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "opacity .95, class:(.*)"
    ];

    layerrule = [
      # "blur, *"
      # "blurpopups, *"
    ];
  };
}
