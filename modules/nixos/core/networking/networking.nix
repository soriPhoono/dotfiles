{
  imports = [
    ./openssh.nix
    ./network-manager.nix
  ];

  config = {
    networking = {
      useDHCP = false;
      dhcpcd.enable = false;

      nameservers = ["9.9.9.9#dns.quad9.net"];

      nftables.enable = true;
    };

    services.timesyncd.enable = true;
  };
}
