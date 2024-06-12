# TODO: configure dnsmasq

{ pkgs, vars, ... }: {
  networking = {
    networkmanager = {
      enable = true;

      plugins = with pkgs; [
        networkmanager-openvpn
        networkmanager-openconnect
      ];

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
