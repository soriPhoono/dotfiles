{
  imports = [
    ./openssh.nix
    ./network-manager.nix
  ];

  config = {
    networking = {
      nameservers = ["9.9.9.9#dns.quad9.net"];

      nftables.enable = true;
    };

    services = {
      resolved = {
        enable = true;

        dnsovertls = "opportunistic";
      };
    };

    services.timesyncd.enable = true;
  };
}
