{config, ...}: {
  imports = [
    ./openssh.nix
    ./wireless.nix
  ];

  config = {
    networking.nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];

    services = {
      resolved = {
        enable = true;
        fallbackDns = config.networking.nameservers;
      };

      timesyncd.enable = true;
    };
  };
}
