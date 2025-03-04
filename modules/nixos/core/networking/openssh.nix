{
  lib,
  config,
  ...
}: let
  cfg = config.core.networking.openssh;
in {
  options.core.networking.openssh.enable = lib.mkEnableOption "Enable OpenSSH";

  config = lib.mkIf cfg.enable {
    services.openssh = {
      settings = {
        UseDns = true;
        PermitRootLogin = "prohibit-password";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
  };
}
