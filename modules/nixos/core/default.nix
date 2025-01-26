{
  lib,
  config,
  ...
}: let
  cfg = config.core;
in {
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

    networking.hostName = cfg.hostname;

    facter.reportPath = ../../../hardware-survey/${cfg.hostname}.json;

    system.stateVersion = lib.mkDefault "25.05";
  };
}
