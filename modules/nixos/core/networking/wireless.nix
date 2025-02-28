{
  lib,
  config,
  ...
}: let
  cfg = config.core.networking.wireless;
in {
  options.core.networking.wireless = {
    enable = lib.mkEnableOption "Enable wireless networking";

    secretsFile = lib.mkOption {
      type = lib.types.path;
      description = "Secrets file for wireless network configuration";
    };

    networks = lib.mkOption {
      type = lib.types.attrs;
      description = "Network configuration for wireless devices";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.wireless = {
      inherit (cfg) networks secretsFile;

      enable = true;
      userControlled.enable = true;
      allowAuxiliaryImperativeNetworks = true;
    };
  };
}
