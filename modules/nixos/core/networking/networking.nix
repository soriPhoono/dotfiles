{
  imports = [
    ./network-manager.nix

    ./openssh.nix
  ];

  networking = {
    nameservers = ["9.9.9.9#dns.quad9.net"];

    nftables.enable = true;
  };

  services.timesyncd.enable = true;
}
