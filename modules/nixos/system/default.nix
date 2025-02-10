{lib, ...}: {
  imports = [
    ./disk.nix
    ./boot.nix
    ./secure-boot.nix
    ./impermanence.nix
    ./secrets.nix
    ./users.nix
    ./power.nix
    ./audio.nix
    ./bluetooth.nix
    ./location.nix
  ];

  time.timeZone = lib.mkDefault "America/Chicago";

  networking.hostName = lib.mkDefault "nixos";

  services = {
    dbus.implementation = "broker";
  };

  system.stateVersion = "25.05";
}
