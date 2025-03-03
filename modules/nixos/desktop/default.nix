{
  imports = [
    ./environments/kde.nix
    ./environments/noir.nix

    ./programs/regreet.nix

    ./services/asusd.nix
    ./services/greetd.nix

    ./suites/gaming.nix
  ];
}
