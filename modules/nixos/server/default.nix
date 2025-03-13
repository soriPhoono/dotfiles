{
  lib,
  config,
  ...
}: let
  cfg = config.server;
in {
  imports = [
    ./containers/nextcloud.nix
  ];

  options.server = {
    enable = lib.mkEnableOption "Enable server configuration mode";

    ethernet-interface = lib.mkOption {
      type = lib.types.str;
      description = "The ethernet interface to use for the server";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.nat = {
      enable = true;
      internalInterfaces = ["ve-+"];
      externalInterface = "enp4s0f4u2";
      enableIPv6 = true;
    };
  };
}
