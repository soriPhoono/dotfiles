{ pkgs, ... }: {
  imports = [
    ./xdg-portal.nix
    ./gtk.nix
    ./qt.nix
    ./notifications.nix
    ./waybar.nix

    ./conf
  ];

  home.packages = with pkgs; [
    # System
    playerctl
    # Visuals
    brightnessctl # Brightness
    gammastep # Nightcolor
    # File manager
    gnome.file-roller
    gnome.nautilus
  ];
}
