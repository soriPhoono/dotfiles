{lib, ...}: {
  imports = [
    ./nixconfig.nix

    ./admin.nix
    ./shell.nix
  ];

  time.timeZone = lib.mkDefault "America/Chicago";

  system.stateVersion = lib.mkDefault "25.05";
}
