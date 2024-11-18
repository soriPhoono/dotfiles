{ lib, config, ... }:
let cfg = config.core.openssh;
in {
  options = {
    core.openssh.enable = lib.mkEnableOption "Enable openssh support";
  };

  config = {
    services.openssh = {
      enable = true;
    } // lib.mkIf cfg.enable {
      # hostKeys = [{
      #   comment = "soriphoono ${config.networking.hostName}";

      #   path = "/etc/ssh/ssh_host_ed25519_key";
      #   type = "ed25519";
      # }];

      # settings = {
      #   PermitRootLogin = "no";
      #   PasswordAuthentication = false;
      #   KbdInteractiveAuthentication = false;
      # };
    };
  };
}
