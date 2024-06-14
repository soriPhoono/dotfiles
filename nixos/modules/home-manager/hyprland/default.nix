{ pkgs, ... }: {
  imports = [
    ./xdg-portal.nix
    ./gtk.nix
    ./qt.nix
    ./notifications.nix
    ./alacritty.nix
    ./waybar.nix

    ./conf
  ];

  home.packages = with pkgs; [
    # System
    glib
    playerctl
    # Visuals
    brightnessctl # Brightness
    gammastep # Nightcolor
    # File manager
    gnome.file-roller
    gnome.nautilus
  ];
}
