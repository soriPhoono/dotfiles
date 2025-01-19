{lib, ...}: {
  imports = [
    ./nixconfig.nix

    ./admin.nix
    ./secrets.nix
    ./shell.nix
  ];

  options.core = {
    hostname = lib.mkOption {
      type = lib.types.str;
      description = "The system host name to create";
    };
  };

  config = {
    time.timeZone = lib.mkDefault "America/Chicago";

    system.stateVersion = lib.mkDefault "25.05";
  };
}
