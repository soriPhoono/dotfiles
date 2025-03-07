{
  imports = [
    ./environments/noir.nix

    ./programs/regreet.nix
    ./programs/hyprland.nix
    ./programs/hyprlock.nix

    ./services/asusd.nix
    ./services/greetd.nix
    ./services/gvfs.nix
    ./services/polkit.nix
    ./services/hypridle.nix

    ./suites/gaming.nix
  ];
}
