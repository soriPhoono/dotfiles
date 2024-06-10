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
    gammastep # Monitor brightness
    wlsunset # Nightcolor
    # Clipboard
    wl-clipboard
    cliphist
    # Applications
    gnome.nautilus
    gnome.file-roller
    blueberry
    networkmanagerapplet
  ];
}
