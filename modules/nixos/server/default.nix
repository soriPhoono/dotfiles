{lib, ...}: {
  options.server.enable = lib.mkEnableOption "Enable server configuration mode";

  config = {
    networking = {
      bridges.br0.interfaces = [
        "ethernet-here" # TODO: fix this
      ];

      useDHCP = false;

      interfaces.br0 = {
        useDHCP = true;
        ipv4.addresses = [
          {
            address = "192.168.100.3";
            prefixLength = 24;
          }
        ];
        defaultGateway = "192.168.100.1";
        nameservers = [
          "192.168.100.1"
        ];
      };
    };
  };
}
