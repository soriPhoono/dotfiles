{
  imports = [
    ./environments/noir.nix

    ./programs/regreet.nix

    ./services/asusd.nix
    ./services/greetd.nix

    ./suites/gaming.nix
  ];
}
