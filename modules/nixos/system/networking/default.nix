{
  lib,
  config,
  ...
}: let
  cfg = config.system.networking;
in {
  imports = [
    ./firewall.nix
    ./tailscale.nix
  ];

  options.system.networking = {
    enable = lib.mkEnableOption "Enable networking";
  };

  config = lib.mkIf cfg.enable {
    networking = {
      nameservers = ["9.9.9.9#dns.quad9.net"];

      networkmanager = {
        enable = true;
        dns = "systemd-resolved";
        wifi.powersave = true;
      };
    };

    users.users = lib.genAttrs config.system.users (_: {extraGroups = ["networkmanager"];});

    services = {
      openssh = {
        enable = true;

        startWhenNeeded = true;

        settings = {
          UseDns = true;
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
      };

      resolved = {
        enable = true;

        dnsovertls = "opportunistic";
      };

      timesyncd.enable = true;
    };

    system.impermanence.directories = [
      "/etc/NetworkManager/system-connections"
    ];
  };
}
