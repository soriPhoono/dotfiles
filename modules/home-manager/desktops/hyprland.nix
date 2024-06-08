{ pkgs, ... }: {
  home.packages = with pkgs; [
    # System
    polkit_gnome
    libgnome-keyring
    playerctl
    xwaylandvideobridge
    grimblast
    # Visuals
    swww # Wallpaper
    gammastep # Monitor brightness
    wlsunset # Nightcolor
    # Clipboard
    wl-clipboard
    cliphist
  ];

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];

    configPackages = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };

  programs.ags = {
    enable = true;

    configDir = ../../../ags;

    extraPackages = with pkgs; [

    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";

      monitor = [
        ",1920x1080@144,0x0,1.5"
      ];

      exec-once = [
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"

        "swww-daemon"
        "swww img ${../../../assets/wallpapers/1.png}"
      ];

      exec = [

      ];

      bind = [
        "$mod, Q, killactive, "
        "$mod_SHIFT, Q, exit, "

        "$mod, Return, exec, alacritty"
        "$mod, B, exec, firefox"
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioPlay, exec, playerctl play-pause"

        ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
      ];

      bindl = [
        # TODO: lookup devices and create switch to disable monitor if lid is closed
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      windowrulev2 = [
        "opacity .8, class:(.*)"
      ];

      layerrule = [
        "blur, *"
        "blurpopups, *"
      ];
    };
  };
}
