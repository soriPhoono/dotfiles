{
  lib,
  config,
  ...
}: let
  cfg = config.system.networking;
in {
  options.system.networking = {
    enable = lib.mkEnableOption "Enable networking";

    networkmanager.enable = lib.mkEnableOption "Enable network manager script for wifi management";
    ssh.enable = lib.mkEnableOption "Enable ssh connections";
  };

  config = lib.mkIf cfg.enable {
    networking = {
      hostName = config.core.hostname;

      firewall.enable = true;
      nftables.enable = true;

      networkmanager.enable = cfg.networkmanager.enable;
    };

    users.users.${config.core.admin.name}.extraGroups = lib.mkIf cfg.networkmanager.enable ["networkmanager"];

    services = {
      openssh = lib.mkIf cfg.ssh.enable {
        startWhenNeeded = true;
        passwordAuthentication = false;

        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
      };

      timesyncd.enable = true;
    };
  };
}
