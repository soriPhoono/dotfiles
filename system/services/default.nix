{ ... }: {
  services = {
    dbus.implementation = "broker";

    udev.extraRules = ''
    '' # TODO: add extra udev rules for notifications on hardware mods here
  };
}
