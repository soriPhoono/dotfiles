{
  lib,
  config,
  ...
}: let
  cfg = config.system.secure-boot;
in {
  options.system.secure-boot = {
    enable = lib.mkEnableOption "Enable secure boot based kernel";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      loader.systemd-boot.enable = lib.mkForce false;

      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
    };

    environment.persistence."/persist".directories = [
      "/var/lib/sbctl"
    ];
  };
}
