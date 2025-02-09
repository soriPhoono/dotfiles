{
  lib,
  config,
  ...
}: let
  cfg = config.system;
in {
  imports = [
    ./boot.nix
    ./power.nix
    ./audio.nix
    ./bluetooth.nix
    ./location.nix
  ];

  options.system.enable = lib.mkEnableOption "Enable basic system configuration";

  config = lib.mkIf cfg.enable {
    system = {
      boot.enable = true;
      power.enable = true;
    };

    services = {
      dbus.implementation = "broker";
    };
  };
}
