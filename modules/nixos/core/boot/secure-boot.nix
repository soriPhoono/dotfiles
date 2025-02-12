{
  lib,
  config,
  ...
}: let
  cfg = config.core.boot.secure-boot;
in {
  options.core.boot.secure-boot.enable = lib.mkEnableOption "Enable secure boot features on a device (DANGEROUS)";

  config = lib.mkIf (config.core.boot.enable && cfg.enable) {
    boot = {
      loader.systemd-boot.enable = lib.mkForce false;

      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
    };

    core.boot.impermanence.directories = [
      "/var/lib/sbctl"
    ];
  };
}
