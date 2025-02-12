{
  imports = [
    ./network-manager.nix

    ./openssh.nix
    ./tailscale.nix
  ];

  config = {
    networking = {
      nameservers = ["9.9.9.9#dns.quad9.net"];

      nftables.enable = true;
    };

    services.resolved = {
      enable = true;

      dnsovertls = "true";
    };

    services.timesyncd.enable = true;
  };
}
