# TODO: configure dnsmasq

{ ... }: {
  networking = {
    networkmanager = {
      enable = true;

      ethernet.macAddress = "random";

      wifi = {
        powersave = false;

        macAddress = "random";
      };
    };
  };
}
