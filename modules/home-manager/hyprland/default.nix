{ pkgs, ... }: {
  imports = [
    ./xdg-portal.nix
    ./gtk.nix
    ./qt.nix
    ./mpd.nix
    ./notifications.nix
    ./waybar.nix

    ./conf
  ];

  home.packages = with pkgs; [
    # Visuals
    gammastep # Nightcolor
    # File manager
    gnome.file-roller
    # Wireless
    networkmanagerapplet
  ];
}
