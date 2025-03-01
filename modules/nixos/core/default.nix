{lib, ...}: {
  imports = [
    ./nix/nixconf.nix

    ./boot/boot.nix

    ./hardware/hardware.nix

    ./networking/networking.nix

    ./services/geoclue2.nix
    ./services/pipewire.nix

    ./suites/users.nix
    ./suites/power.nix
  ];

  time.timeZone = lib.mkDefault "America/Chicago";

  documentation.man.generateCaches = false;

  services.dbus.implementation = "broker";

  system.stateVersion = "25.05";
}
