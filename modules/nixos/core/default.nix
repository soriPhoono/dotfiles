{lib, ...}: {
  imports = [
    ./nixconfig.nix

    ./admin.nix
    ./secrets.nix
    ./shell.nix
  ];

  options.core.hostname = lib.mkOption {
    type = lib.types.str;
    default = "nixos";
    description = "The hostname of the system";
  };

  config = {
    time.timeZone = lib.mkDefault "America/Chicago";

    system.stateVersion = lib.mkDefault "25.05";
  };
}
