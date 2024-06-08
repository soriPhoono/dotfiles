{ inputs, pkgs, ... }: {
  home.packages = with pkgs; [
    # System
    polkit-gnome
    gnome-keyring
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

    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    ];

    settings = {
      "$mod" = "SUPER";

      exec-once = [

      ];

      exec = [

      ];

      bind = [
        "$mod, Return, exec, alacritty"
        "$mod, B, exec, firefox"
        "$mod, Q, killactive, "
      ];
    };
  };
}
