{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.system.networking;
in {
  imports = [
    ./avahi.nix
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

    environment.persistence."/persist".directories = [
      "/etc/NetworkManager/system-connections"
    ];

    users.users = lib.genAttrs (map (user: user.name) config.core.users) (name: {extraGroups = ["networkmanager"];});

    services = {
      openssh = {
        startWhenNeeded = true;

        settings = {
          UseDns = true;
          PermitRootLogin = "no";
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
  };
}
