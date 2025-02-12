{lib, ...}: {
  imports = [
    ./boot/boot.nix

    ./hardware/hardware.nix

    ./networking/networking.nix

    ./users.nix
    ./power.nix
    ./audio.nix
    ./bluetooth.nix
  ];

  time.timeZone = lib.mkDefault "America/Chicago";

  services.dbus.implementation = "broker";

  system.stateVersion = "25.05";
}
