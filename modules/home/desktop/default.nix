{
  imports = [
    ./noir/noir.nix

    ./programs/fuzzel.nix
    ./programs/waybar.nix
    ./programs/hyprlock.nix
    ./programs/ghostty.nix
    ./programs/nautilus.nix

    ./services/mako.nix
    ./services/hypridle.nix
    ./services/gammastep.nix
    ./services/gnome-keyring.nix
  ];
}
