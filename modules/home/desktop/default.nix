{
  imports = [
    ./programs/fuzzel.nix
    ./programs/feh.nix
    ./programs/mpv.nix
    ./programs/waybar.nix
    ./programs/hyprpanel.nix
    ./programs/hyprlock.nix
    ./programs/nautilus.nix
    ./programs/hyprland.nix
    ./programs/ghostty.nix
    ./programs/zathura.nix

    ./services/mako.nix
    ./services/hypridle.nix
    ./services/gammastep.nix
    ./services/gnome-keyring.nix

    ./environments/noir/noir.nix
    ./environments/gnome/gnome.nix
  ];
}
