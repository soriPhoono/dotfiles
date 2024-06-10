{ pkgs, ... }: {
  imports = [
    ./xdg-portal.nix
    ./gtk.nix
    ./qt.nix
    ./mako.nix

    ./hypridle.nix
    ./hyprlock.nix

    ./conf
  ];

  home.packages = with pkgs; [
    # Visuals
    gammastep # Monitor brightness
    wlsunset # Nightcolor
    # Clipboard
    wl-clipboard
    cliphist
    # File manager
    gnome.nautilus
    gnome.file-roller
    # Wireless
    blueberry
    networkmanagerapplet
    # Wallpaper
    swww
  ];
}
