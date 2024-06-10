# TODO: configure dnsmasq

{ ... }: {
  networking = {
    networkmanager = {
      enable = true;

      dns = "systemd-resolved";

      ethernet.macAddress = "random";
      wifi = {
        powersave = false;

        macAddress = "random";
      };
    };
  };

  services.resolved.enable = true;
}