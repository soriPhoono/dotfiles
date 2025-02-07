{
  imports = [
    ./boot.nix
    ./power.nix
    ./audio.nix
    ./location.nix
  ];

  services = {
    dbus.implementation = "broker";

    psd = {
      enable = true;
      resyncTimer = "10m";
    };
  };
}
