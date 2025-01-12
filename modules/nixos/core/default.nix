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
    enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enable the core module";

      default = true;
    };

    region = lib.mkOption {
      type = lib.types.str;
      description = "The timezone of the system";

      default = "America/Chicago";
    };

    version = lib.mkOption {
      type = lib.types.str;
      description = "The system version to build against";

      default = "25.05";
    };
  };

  config = lib.mkIf cfg.enable {
    time.timeZone = cfg.region;

    system.stateVersion = cfg.version;
  };
}
