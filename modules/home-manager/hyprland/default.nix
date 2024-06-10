{ pkgs, ... }: {
  imports = [
    ./xdg-portal.nix
    ./gtk.nix
    ./qt.nix
    ./mako.nix

    ./conf
  ];

  home.packages = with pkgs; [
    # Visuals
    brightnessctl # Monitor and device brightness
    gammastep # Nightcolor
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
