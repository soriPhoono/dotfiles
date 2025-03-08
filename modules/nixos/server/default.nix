{
  lib,
  config,
  ...
}: let
  cfg = config.server;
in {
  options.server = {
    enable = lib.mkEnableOption "Enable server configuration mode";

    ethernet-interface = lib.mkOption {
      type = lib.types.str;
      description = "The ethernet interface to use for the server";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.interfaces.${cfg.ethernet-interface}.wakeOnLan.enable = true;
  };
}
