{
  imports = [
    ./programs/fuzzel.nix
    ./programs/waybar.nix
    ./programs/hyprlock.nix
    ./programs/nautilus.nix
    ./programs/hyprland.nix

    ./services/mako.nix
    ./services/hypridle.nix
    ./services/gammastep.nix
    ./services/gnome-keyring.nix

    ./environments/noir/noir.nix
  ];
}
