{
  imports = [
    ./environments/kde.nix
    ./environments/noir.nix

    ./programs/greetd.nix

    ./services/asusd.nix
    ./services/greetd.nix

    ./suites/gaming.nix
  ];
}
