{
  imports = [
    ./environments/noir.nix

    ./programs/regreet.nix
    ./programs/hyprlock.nix

    ./services/asusd.nix
    ./services/greetd.nix
    ./services/hypridle.nix

    ./suites/gaming.nix
  ];
}
