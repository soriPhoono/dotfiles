{ ... }: {
  imports = [
    ./core.nix
    ./file-system.nix
    ./localization.nix
    ./network-manager.nix
    ./power-handling.nix
  ];
}