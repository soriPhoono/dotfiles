{lib, ...}: {
  imports = [
    ./nix/nixconf.nix
    ./nix/nh.nix

    ./boot/boot.nix

    ./hardware/hardware.nix

    ./networking/networking.nix

    ./services/asusd.nix
    ./services/geoclue2.nix

    ./users.nix
    ./power.nix
    ./audio.nix
    ./bluetooth.nix
  ];

  time.timeZone = lib.mkDefault "America/Chicago";

  documentation.man.generateCaches = false;

  services.dbus.implementation = "broker";

  system.stateVersion = "25.05";
}
