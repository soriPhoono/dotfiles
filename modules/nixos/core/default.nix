{ lib, config, ... }:
let
  this = "core";

  cfg = config."${this}";
in
{
  imports = [
    ./admin.nix
    ./nixconf.nix
  ];

  options."${this}" = {
    enable = lib.mkEnableOption "Enable this module";

    timeZone = lib.mkOption {
      type = lib.types.str;
      description = "The timezone of the system";

      default = "America/Chicago";
    };

    systemVersion = lib.mkOption {
      type = lib.types.str;
      description = "The system version to build against";

      default = "25.05";
    };
  };

  config = lib.mkIf cfg.enable {
    time.timeZone = cfg.timeZone;

    system.stateVersion = cfg.systemVersion;
  };
}
