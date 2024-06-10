# TODO: configure dnsmasq

{ vars, ... }: {
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

  users.users.${vars.defaultUser}.extraGroups = [
    "networkmanager"
  ];
}
