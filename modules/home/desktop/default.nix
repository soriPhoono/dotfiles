{
  imports = [
    ./programs/fuzzel.nix
    ./programs/waybar.nix
    ./programs/hyprlock.nix
    ./programs/nautilus.nix

    ./hyprland/general.nix

    ./services/mako.nix
    ./services/hypridle.nix
    ./services/gammastep.nix
    ./services/gnome-keyring.nix

    ./environments/noir.nix
  ];
}
