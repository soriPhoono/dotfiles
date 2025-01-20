{lib, ...}: {
  imports = [
    ./nixconfig.nix

    ./admin.nix
    ./secrets.nix
    ./shell.nix
  ];

  config = {
    time.timeZone = lib.mkDefault "America/Chicago";

    system.stateVersion = lib.mkDefault "25.05";
  };
}
