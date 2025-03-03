{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.services.greetd;
in {
  options.desktop.services.greetd.enable = lib.mkEnableOption "Enable regreet system";

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      vt = 1;
    };

    security.pam.services.greetd.enableGnomeKeyring = true;
  };
}
