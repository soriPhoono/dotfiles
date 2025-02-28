{config, ...}: {
  imports = [
    ./openssh.nix
    ./wireless.nix
  ];

  config = {
    networking.nameservers = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
    ];

    services = {
      resolved = {
        enable = true;
        dnssec = "true";
        dnsovertls = "true";
        fallbackDns = config.networking.nameservers;
      };

      timesyncd.enable = true;
    };
  };
}
